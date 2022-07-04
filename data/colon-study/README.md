# Colon dataset extraction

## Dataset information
This dataset contains sociodemographic information of patients and information about their tumours. The dataset used to apply the statistical analysis can not be published because it contains confidential information. The study complies and maintains the anonymity of the patients.
Variables:

* Gender (Male, Female)
* Age group (50-64, 65-74, >75)
* Death (Yes, No)
* Body Mass Index (BMI) (Normal, overweight, obesity)
* Smoking (Ex-smoker/smoker, non-smoker)
* Population type (Rural, Semi-urban, Urban)
* Income (high-income, low-income)
* Tumour stage (0, I, II, III, undefined)


## Databases
This information was extracted from different databases. The sources used were next:

* **Population cancer registry of Lleida**(Gender, Age, Population, Death, Tumour stage). This database collects all the patient cancer cases diagnosed in the Lleida region. Also, it contains all the information related to the tumour as location, morphology or stage. It is a relational database with two important patient and tumour information tables.

* **eCAP**: computerized medical history program used by doctors and nurses in Primary Care Centers (Smoking and BMI). Relational database with the clinical history information.

* **RCA**: The register allows the unique identification of those covered by the Catalan Health Service (Incomes). This system knows the incomes of each patient to apply some benefits depending on the incomes level. This information was received by plain file.


## Extraction

The final dataset was built by python script that selected the patients with colorectal cancer diagnosed between 2012 and 2015. Next, we obtained the smoking exposition and the BMI when each patient was diagnosed. And finally, the level of income of each patient.


## Analysis 

The R script to analyse this dataset is in [a link](https://github.com/didacflorensa/MCA-Cancer/blob/master/r-scripts/ColonRectum/mca_r.R)


## Data Generator

The mock_generator.py reproduced the same structure used for the analysis by random data.
 