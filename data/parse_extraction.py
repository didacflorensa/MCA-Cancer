import csv

'''

This script reads the sql extraction and it prepares to the R scripts.
It categorizes the age, the population, gender and type of cancer.

'''
def read_file_and_parse_file():
    cancerSelection = ['C18', 'C19', 'C20', 'C21', 'C34', 'C50', 'C61', 'C67']
    #cancerSelection = ['C50']
    with open('extraction_sql_data.csv') as csv_file:
        csv_reader = csv.reader(csv_file, delimiter=';')
        line_count = 0
        f = open('mock.csv', 'a')  # Create result file
        f.write('"id","age_group","gender","population","cancer"\n')
        id_line = 1
        for row in csv_reader:
            if line_count == 0: #Read the column names
                print('Column names are ', row)
                line_count += 1
            else:  # Process line
                if str(row[3]) in cancerSelection:
                    processLine(f, row, id_line)
                    id_line += 1

                line_count += 1

        f.close()


def processLine(f, row, id_line):
    population = returnCorrectPopulation(int(row[2]))
    sex = returnSex(int(row[1]))
    ageGroup = returnAgeGroup(int(row[0]))
    cancer = returnTypeCancer(str(row[3]))

    if population == "Urban":
        f.write('"' + str(id_line) + '","'+ str(ageGroup) + '","' + str(sex) + '","'+ str(cancer) + '","' + str(population) + '"\n')



def returnCorrectPopulation(population):
    urbanDictionaryPopulation = [25001, 25002, 25003, 25004, 25005, 25006, 25007, 25008, 25196, 25198, 25199, 25300,
                                 25230, 25600, 25700] # The id of populations which are considered urban (>10.000 inhabitants)

    if population in urbanDictionaryPopulation:
        return "Urban"
    else:
        return "Rural"


def returnSex(sex):
    if sex == 1 :
        return "Male"
    else:
        return "Female"


def returnAgeGroup(age):
    if 0 <= age <= 60:
        return "<60"
    elif 61 <= age <= 70:
        return "60 - 70"
    elif 71 <= age <= 80:
        return "70 - 80"
    elif age >= 81:
        return ">80"



def returnTypeCancer(cancer):

    cancerD = {
        18: "Colon and rectum",
        61:"Prostate",
        50:"Breast",
        67:"Urinary Bladder",
        34:"Lung"
    }

    if cancer == 'C18' or cancer == 'C19' or cancer == 'C20' or cancer == 'C21':
        return cancerD[18]
    elif cancer == 'C34':
        return cancerD[34]
    elif cancer == 'C67':
        return cancerD[67]
    elif cancer == 'C61':
        return cancerD[61]
    elif cancer == 'C50':
        return cancerD[50]
    else:
        return "Other"

if __name__ == "__main__":
    print ("Parsing extraction file")
    read_file_and_parse_file()
