# A machine learning-based integration of flow cytometry, 16S rRNA gene sequencing, and productivity data to associate bacterial taxa with functional groups 

**Abstract:** High-nucleic acid (HNA) and low-nucleic acid (LNA) bacteria are flow cytometry (FCM) functional groups that are ubiquitous across aquatic systems. Correlations between bacterial heterotrophic production and HNA cells suggest that HNA cells are more active. However, the composition of bacterial taxa within HNA and LNA groups is not well understood. Here, we used a machine learning based variable selection strategy, called the Randomized Lasso (RL), to associate bacterial representatives with the HNA and LNA groups. FCM and 16S rRNA gene sequencing data were collected across three freshwater lake ecosystems and heterotrophic productivity measurements were gathered in one. There was a strong association between bacterial heterotrophic production and HNA cell abundances (R2 = 0.65), and not with the more dominant LNA cells. While the RL resulted in models able to predict HNA and LNA cell abundances at all taxonomic classification levels, they performed best at the OTU level. Selected OTUs were mostly unique to each lake ecosystem indicating high system specificity. Some OTUs were selected for both FCM functional groups indicating either within-OTU functional diversification or plasticity that allows transitioning between functional states. Our approach allows for categorizing OTUs into FCM functional groups and thus identification of the more active taxa in aquatic systems.


## [Link to Analysis for Figures 1, 4, 5, and Phylogenetic Signal](Analysis.html) 
**NOTE:** This file needs to be downloaded and opened in a browser

## Variable selection
Examples of how variable selection was performed using the Randomized Lasso and Boruta algorithm are given in two Jupyter notebooks: [fs_Muskegon_HNA_5seq10.ipynb](https://github.com/rprops/HNA_LNA_productivity/blob/master/fs_Muskegon_HNA_5seq10.ipynb) and [fs_Muskegon_LNA_5seq10.ipynb](https://github.com/rprops/HNA_LNA_productivity/blob/master/fs_Muskegon_LNA_5seq10.ipynb). Scripts to perform recursive variable elimination for these cases can be found in [RFE_HNA_MUS_5seq10_RFE_Lasso.py](https://github.com/rprops/HNA_LNA_productivity/blob/master/RFE_HNA_MUS_5seq10_RFE_Lasso.py) and [RFE_LNA_MUS_5seq10_RFE_Lasso.py](https://github.com/rprops/HNA_LNA_productivity/blob/master/RFE_LNA_MUS_5seq10_RFE_Lasso.py). Figures 2 and 3 can be generated with the [plot_Fig2.py](https://github.com/rprops/HNA_LNA_productivity/blob/master/plot_Fig2.py) and [plot_Fig3.py](https://github.com/rprops/HNA_LNA_productivity/blob/master/plot_Fig3.py) scripts. Functions that are used can be found in the file `analysis_functions.py`. 

### Results
Variable selection results for all all lake systems are stored in the directory [FS_final](https://github.com/rprops/HNA_LNA_productivity/tree/master/FS_final). Results based on a  recursive variable elimination can be found in the directory [RFE](https://github.com/rprops/HNA_LNA_productivity/tree/master/RFE). 

### Dependencies
* [Numpy](http://www.numpy.org/): Scientific Computing with Python. 
* [Pandas](https://pandas.pydata.org): Python Data Structure and Analysis Library. 
* [Scikit-Learn](http://scikit-learn.org/stable/): Python Machine Learning Library. 
* [Boruta_py](https://github.com/scikit-learn-contrib/boruta_py): Pythom implementation of the Boruta algorithm. 
