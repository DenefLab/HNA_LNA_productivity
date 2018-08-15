# Using machine learning to associate bacterial taxa with functional groups through flow cytometry, 16S rRNA gene sequencing, and productivity data

**Abstract:** High- (HNA) and low-nucleic acid (LNA) bacteria are two separated flow cytometry (FCM) groups that are ubiquitous across aquatic systems. HNA cell density often correlates strongly with heterotrophic production. However, the taxonomic composition of bacterial taxa within HNA and LNA groups remains mostly unresolved. Here, we associated freshwater bacterial taxa with HNA and LNA groups by integrating FCM and 16S rRNA gene sequencing using a machine learning-based variable selection approach. There was a strong association between bacterial heterotrophic production and HNA cell abundances (R2 = 0.65), but not with more abundant LNA cells, suggesting that the smaller pool of HNA bacteria may play a disproportionately large role in the freshwater carbon flux. Variables selected by the models were able to predict HNA and LNA cell abundances at all taxonomic levels, with highest accuracy at the OTU level. There was high system specificity as the selected OTUs were mostly unique to each lake ecosystem and some OTUs were selected for both groups or were rare. Our approach allows for the association of OTUs with FCM functional groups and thus the identification of putative indicators of heterotrophic activity in aquatic systems, an approach that can be generalized to other ecosystems and functioning of interest. 

**Authors:** *Peter Rubbens, Marian L. Schmidt,* Ruben Props, Bopaiah A. Biddanda, Nico Boon, Willem Waegeman, Vincent J. Denef  


*Peter Rubbens and Marian L. Schmidt contributed equally to this work.*  


## Variable selection
Examples of how variable selection was performed using the Randomized Lasso and Boruta algorithm are given in two Jupyter notebooks: [fs_Muskegon_HNA_5seq10.ipynb](https://github.com/rprops/HNA_LNA_productivity/blob/master/fs_Muskegon_HNA_5seq10.ipynb) and [fs_Muskegon_LNA_5seq10.ipynb](https://github.com/rprops/HNA_LNA_productivity/blob/master/fs_Muskegon_LNA_5seq10.ipynb). Scripts to perform recursive variable elimination for these cases can be found in [RFE_HNA_MUS_5seq10_RFE_Lasso.py](https://github.com/rprops/HNA_LNA_productivity/blob/master/RFE_HNA_MUS_5seq10_RFE_Lasso.py) and [RFE_LNA_MUS_5seq10_RFE_Lasso.py](https://github.com/rprops/HNA_LNA_productivity/blob/master/RFE_LNA_MUS_5seq10_RFE_Lasso.py). Figures 2 and 3 can be generated with the [plot_Fig2.py](https://github.com/rprops/HNA_LNA_productivity/blob/master/plot_Fig2.py) and [plot_Fig3.py](https://github.com/rprops/HNA_LNA_productivity/blob/master/plot_Fig3.py) scripts. Functions that are used can be found in the file `analysis_functions.py`. 

### Results
Variable selection results for all all lake systems are stored in the directory [FS_final](https://github.com/rprops/HNA_LNA_productivity/tree/master/FS_final). Results based on a  recursive variable elimination can be found in the directory [RFE](https://github.com/rprops/HNA_LNA_productivity/tree/master/RFE). 

### Dependencies
* [Numpy](http://www.numpy.org/): Scientific Computing with Python. 
* [Pandas](https://pandas.pydata.org): Python Data Structure and Analysis Library. 
* [Scikit-Learn](http://scikit-learn.org/stable/): Python Machine Learning Library. 
* [Boruta_py](https://github.com/scikit-learn-contrib/boruta_py): Pythom implementation of the Boruta algorithm. 


## Phylogenetic Signal
Please [click here for the code for Phylogenetic Signal](Analysis.html).  

### Phylogenetic Tree Construction  
The phylogenetic tree in Figure 5 was calculated using [fasttree](http://www.microbesonline.org/fasttree/) and was visualized in [iTOL](https://itol.embl.de/). Data files imported for tree construction can be found in [data/Figure5](data/Figure5).  

## Other Code  
Please [click here for the code for Figures 1, 4, and 5](Analysis.html).  

## Supplemental Information  
The supplemental tables and figures can be found in [supplemental_info/](supplemental_info/).
