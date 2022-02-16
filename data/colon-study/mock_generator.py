import sys
import random

GENDER = ['Male', 'Female']
AGE_GROUPS = ['50-64', '65-74', '>75']
POPULATION = ['Rural', 'Urban']
EXITUS = ['exitus_yes, exitus_no']
BMI = ['normal', 'overweight', 'obesity']
SMOKING = ['smoker', 'non-smoker']
INCOME = ['high_income', 'low_income']
STAGE = ['stage_0', 'stage_I', 'stage_II', 'stage_III']

def get_random_element(parse_array):
    size = len(parse_array)
    np_random = random.randrange(0, size)
    
    return parse_array[np_random]


if __name__ == "__main__":
    print("Mock generator")
    f_write = open("mock.csv", "w")
    f_write.write("gender,age_group,population,exitus,bmi,smoking,income,stage\n")

    for i in range(0, 100):
        gender = get_random_element(GENDER)
        age_group = get_random_element(AGE_GROUPS)
        population = get_random_element(POPULATION)
        exitus = get_random_element(EXITUS)
        bmi = get_random_element(BMI)
        smoking = get_random_element(SMOKING)
        income = get_random_element(INCOME)
        stage = get_random_element(STAGE)

        f_write.write(gender + "," + age_group + "," + population + "," + exitus + "," + bmi + "," + smoking + "," + income + "," + stage + "," + "\n")

    
    f_write.close()