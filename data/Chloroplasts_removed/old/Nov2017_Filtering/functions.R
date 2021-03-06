# Function for creating a common legend for 2 ggplot2 figures.
grid_arrange_shared_legend <- function(..., ncol = length(list(...)), nrow = 1, position = c("bottom", "right")) {
  
  plots <- list(...)
  position <- match.arg(position)
  g <- ggplotGrob(plots[[1]] + theme(legend.position = position))$grobs
  legend <- g[[which(sapply(g, function(x) x$name) == "guide-box")]]
  lheight <- sum(legend$height)
  lwidth <- sum(legend$width)
  gl <- lapply(plots, function(x) x + theme(legend.position="none"))
  gl <- c(gl, ncol = ncol, nrow = nrow)
  
  combined <- switch(position,
                     "bottom" = arrangeGrob(do.call(arrangeGrob, gl),
                                            legend,
                                            ncol = 1,
                                            heights = unit.c(unit(1, "npc") - lheight, lheight)),
                     "right" = arrangeGrob(do.call(arrangeGrob, gl),
                                           legend,
                                           ncol = 2,
                                           widths = unit.c(unit(1, "npc") - lwidth, lwidth)))
  grid.newpage()
  grid.draw(combined)
  
}

### Functions for extracting the predicted R squared from lm models.
model_fit_stats <- function(linear.model) {
  r.sqr <- summary(linear.model)$r.squared
  adj.r.sqr <- summary(linear.model)$adj.r.squared
  pre.r.sqr <- pred_r_squared(linear.model)
  PRESS <- PRESS(linear.model)
  return.df <- data.frame(r.squared = r.sqr, adj.r.squared = adj.r.sqr, pred.r.squared = pre.r.sqr, press = PRESS)
  return(return.df)
}

pred_r_squared <- function(linear.model) {
  #' Use anova() to get the sum of squares for the linear model
  lm.anova <- anova(linear.model)
  #' Calculate the total sum of squares
  tss <- sum(lm.anova$'Sum Sq')
  # Calculate the predictive R^2
  pred.r.squared <- 1-PRESS(linear.model)/(tss)
  
  return(pred.r.squared)
}

PRESS <- function(linear.model) {
  #' calculate the predictive residuals
  pr <- residuals(linear.model)/(1-lm.influence(linear.model)$hat)
  #' calculate the PRESS
  PRESS <- sum(pr^2)
  
  return(PRESS)
}

##### Normalization #######

# Better rounding function than R's base round
myround <- function(x) { trunc(x + 0.5) }


# Scales reads by 
# 1) taking proportions
# 2) multiplying by a given library size of n
# 3) rounding 
# Default for n is the minimum sample size in your library
# Default for round is floor
scale_reads <- function(physeq, n = min(sample_sums(physeq)), round = "floor") {
  
  # transform counts to n
  physeq.scale <- transform_sample_counts(physeq, 
                                          function(x) {(n * x/sum(x))}
  )
  
  # Pick the rounding functions
  if (round == "floor"){
    otu_table(physeq.scale) <- floor(otu_table(physeq.scale))
  } else if (round == "round"){
    otu_table(physeq.scale) <- myround(otu_table(physeq.scale))
  }
  
  # Prune taxa and return new phyloseq object
  physeq.scale <- prune_taxa(taxa_sums(physeq.scale) > 0, physeq.scale)
  return(physeq.scale)
}

# Extract Legend from ggplot2 object
g_legend <- function(a.gplot){ 
  tmp <- ggplot_gtable(ggplot_build(a.gplot)) 
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box") 
  legend <- tmp$grobs[[leg]] 
  return(legend)
} 

# Function to pool FCS files based on sample name patterns

FCS_pool <- function(x, stub){
  if(length(stub) == length(x)) cat("-- No samples to merge --")
  for(i in 1:length(stub)){
    index <- grep(stub[i], flowCore::sampleNames(x))
    temp <- flowCore::flowSet(as(x[index], "flowFrame"))
    flowCore::sampleNames(temp) <- as.character(stub[i])
    if(stub[i] == stub[1]){
      concat_x <- temp
    } else {
      concat_x <- flowCore::rbind2(concat_x, temp)
    }
  }
  return(concat_x)
}

# Calculate correlations between bins and OTUs

FPcorSeq <- function(fp, phy, cor_thresh = 0.5, fp_thresh = 1e-10,
                     d = 10, param = c("FL1-H", "FL3-H"),
                     cor_m = "pearson", npoint = 10){
  
  # Make sure the phyloseq and flowbasis object are in same order
  phy@otu_table <- phy@otu_table[match(rownames(fp@basis),
                                       phyloseq::sample_names(phy)), ]
  cat(paste0("\t", "Check if sample names match between fbasis and phyloseq objects:", 
             "\n"))
  cat(paste(rownames(fp@basis),"-", rownames(phy@otu_table), "\n"))
  
  # Normalize fingerprint
  fp@basis <- fp@basis/apply(fp@basis, 1, max)
  
  # Give bins coordinates
  nbin <- fp@nbin
  Y <- c()
  for (i in 1:nbin) Y <- c(Y, rep(i, nbin))
  X <- rep(1:nbin, nbin)
  
  # Position of data in @basis
  npos <- seq(1:nrow(fp@param))[fp@param[, 1] == param[1] & fp@param[, 2] == 
                                  param[2]]
  region <- ((npos - 1) * nbin * nbin + 1):(npos * nbin * nbin)
  
  fp@basis <- fp@basis[, region]
  
  # Additional filtering to reduce number of bins
  X <- X[colSums(fp@basis) > fp_thresh]
  Y <- Y[colSums(fp@basis) > fp_thresh]
  fp@basis <- fp@basis[, colSums(fp@basis) > fp_thresh]
  
  cat(paste0("\t",sum(colSums(fp@basis) > fp_thresh)," bins used to calculate correlation with OTUs: ", min(region), " - ", max(region), 
             "\n"))
  
  # Calculate correlations
  cat(date(), paste0("---- Returning correlations >", 
                     cor_thresh, "\n"))
  for(i in 1:ncol(fp@basis)){
    if(i%%1000 == 0) cat(date(), paste0("---- at bin ", i, "/",  ncol(fp@basis), "\n"))
    cor_temp <- c(); p_temp <- c(); npoint_temp <- c()
    for(j in 1:dim(otu_table(phy))[2]){
      cor_temp[j] <- cor(fp@basis[,i], otu_table(phy)[,j], method = cor_m)
      # p_temp[j] <- cor.test(fp@basis[,i], otu_table(phy)[,j], method = cor_m)$p.value
      npoint_temp[j] <- sum((otu_table(phy)[, j] > 0)&(round(fp@basis[,i], d) > fp_thresh))
    }
    results_m <- data.frame(cor = cor_temp, taxa = taxa_names(phy),
                            X = X[i], Y = Y[i], npoint = npoint_temp)
    
    if(i == 1) results_cat <- results_m
    results_cat <- rbind(results_cat, results_m)
  }
  
  ### Filter out low correlation values
  ### and correlation values calculated with low number of points
  results_cat <- results_cat[abs(results_cat$cor) > cor_thresh, ]
  colnames(results_cat)[3:4] <- param
  cat(date(), paste0("---- Done!\n"))
  return(results_cat)
}


FPcorProd <- function(fp, prod, cor_thresh = 0.5, fp_thresh = 1e-10,
                     d = 10, param = c("FL1-H", "FL3-H"),
                     cor_m = "pearson", npoint = 10){
  
  # Make sure the phyloseq and flowbasis object are in same order
  fp@basis <- fp@basis[rownames(fp@basis) %in% prod$names, ]
  prod <- prod[match(rownames(fp@basis),
                     prod$names), ]
  cat(paste0("\t", "Check if sample names match between fbasis and productivity data:", 
             "\n"))
  cat(paste(rownames(fp@basis),"-", prod$names, "\n"))
  
  # Normalize fingerprint
  fp@basis <- fp@basis/apply(fp@basis, 1, max)
  
  # Give bins coordinates
  nbin <- fp@nbin
  Y <- c()
  for (i in 1:nbin) Y <- c(Y, rep(i, nbin))
  X <- rep(1:nbin, nbin)
  
  # Position of data in @basis
  npos <- seq(1:nrow(fp@param))[fp@param[, 1] == param[1] & fp@param[, 2] == 
                                  param[2]]
  region <- ((npos - 1) * nbin * nbin + 1):(npos * nbin * nbin)
  
  fp@basis <- fp@basis[, region]
  
  # Additional filtering to reduce number of bins
  X <- X[colSums(fp@basis) > fp_thresh]
  Y <- Y[colSums(fp@basis) > fp_thresh]
  fp@basis <- fp@basis[, colSums(fp@basis) > fp_thresh]
  
  cat(paste0("\t",sum(colSums(fp@basis) > fp_thresh)," bins used to calculate correlation with OTUs: ", min(region), " - ", max(region), 
             "\n"))
  
  # Calculate correlations
  cat(date(), paste0("---- Returning correlations >", 
                     cor_thresh, "\n"))
  for(i in 1:ncol(fp@basis)){
    if(i%%1000 == 0) cat(date(), paste0("---- at bin ", i, "/",  ncol(fp@basis), "\n"))
    cor_temp <- c(); p_temp <- c(); npoint_temp <- c()
    # for(j in 1:dim(otu_table(phy))[2]){
    #   cor_temp[j] <- cor(fp@basis[,i], prod$total_bac_abund, method = cor_m)
    #   # p_temp[j] <- cor.test(fp@basis[,i], otu_table(phy)[,j], method = cor_m)$p.value
    #   # npoint_temp[j] <- sum((otu_table(phy)[, j] > 0)&(round(fp@basis[,i], d) > fp_thresh))
    # }
    cor_temp <- cor(fp@basis[,i], prod$total_bac_abund, method = cor_m)
    results_m <- data.frame(cor = cor_temp, 
                            X = X[i], Y = Y[i])
    
    if(i == 1) results_cat <- results_m
    results_cat <- rbind(results_cat, results_m)
  }
  
  ### Filter out low correlation values
  ### and correlation values calculated with low number of points
  results_cat <- results_cat[abs(results_cat$cor) > cor_thresh, ]
  colnames(results_cat)[2:3] <- param
  cat(date(), paste0("---- Done!\n"))
  return(results_cat)
}


