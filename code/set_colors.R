## Purpose:  Set the global colors and shapes based on important factors
## Author: Marian L. Schmidt 
 
 
# Set global colors for the different taxonomic phyla
phylum_colors <- c( 
  Acidobacteria = "navy", 
  Actinobacteria = "blue", 
  Alphaproteobacteria = "orangered", 
  #Aminicenantes = "",
  Armatimonadetes = "wheat", 
  Bacteria_unclassified = "grey70", 
  Bacteroidetes = "cornflowerblue", 
  Betaproteobacteria = "plum1", 
  "Candidate_division_OP3" = "slategray3",
  Chlamydiae = "#A20E42",
  Chlorobi="magenta", 
  Chloroflexi="goldenrod1", 
  Cyanobacteria = "limegreen",
  #"Deinococcus-Thermus" = "black",
  Deltaproteobacteria = "olivedrab", 
  Epsilonproteobacteria = "red3",
  Firmicutes = "papayawhip",
  Gammaproteobacteria = "cyan",
  Gemmatimonadetes = "yellow",
  Gracilibacteria = "darkgreen",
  #JTB23 = "#B5D6AA",
  Latescibacteria = "salmon4",
  Lentisphaerae = "palevioletred1",
  Nitrospirae = "forestgreen",
  Omnitrophica = "red4",
  Parcubacteria = "plum4",
  Planctomycetes = "darkorange", 
  Proteobacteria_unclassified = "greenyellow",
  Spirochaetae = "royalblue",
  TA06 = "peachpuff",
  TA18 = "darkgreen",
  Omnitrophica = "burlywood", 
  unknown_unclassified = "grey88",
  Verrucomicrobia = "purple",
  Proteobacteria_unclassified = "green",
  Proteobacteria = "red", 
  HNA =  "deepskyblue4",
  LNA = "darkgoldenrod1",
  Both = "black" )

# Set colors for the flow cytometry groups
fcm_colors <- c(
  "HNA" = "deepskyblue4",
  "LNA" = "darkgoldenrod1",
  "Total" = "black")

# Set colors for the three types of lake ecosystems
lake_colors <- c(
  "Muskegon" = "#FF933F",  
  "Michigan" =  "#EC4863", 
  "Inland" =  "#5C2849")  

# Set SHAPES for the three types of lake ecosystems
lake_shapes <- c(
  "Inland" = 21, 
  "Michigan" = 23, 
  "Muskegon" = 22)
