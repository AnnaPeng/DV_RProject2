require("jsonlite")
require("RCurl")
require("dplyr")
require("ggplot")
# Change the USER and PASS below to be your UTEid
df <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from employee_salaries where X2014_OVERTIME_PAY is not null"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_pp9774', PASS='orcl_pp9774', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
df
summary(df)
head(df)

#View the table of our data frame EMPLOYEE_SALARIES
tbl_df(df)
View(df)
     
#Data Wrangling 1
df %>% select(CURRENT_ANNUAL_SALARY, DEPARTMENT, POSITION_TITLE) %>% filter(CURRENT_ANNUAL_SALARY >= 80000, DEPARTMENT %in% c("POL", "DOT", "DTS", "HHS", "FRS")) %>% ggplot(aes(x = POSITION_TITLE, y = CURRENT_ANNUAL_SALARY, color = DEPARTMENT)) + geom_point()
#Observations: 
#1. Even for a single position within a department say FRS (Florida Retirement System), employees' salaries vary. The range is up to (160K - 80K = 80K).
#2. The department that has most employees is the HHS (Department of Health and Human Services) or FRS (Florida Retirement System); the department that has the least employees is the DTS (Diplomatic Telecommunications Service)
#3. The higest salary which is near 240K lies in the POL department (Police) and only four employees have salaries over 200K; the majority of the employees' salaries lie between 80K and 120K

#Data Wrangling 2
df %>% select(CURRENT_ANNUAL_SALARY, DEPARTMENT, GENDER) %>% group_by(GENDER) %>% filter(DEPARTMENT %in% c("POL","HHS")) %>% ggplot(aes(x = DEPARTMENT, y = CURRENT_ANNUAL_SALARY, color = GENDER)) + geom_point()
#Observations:
#1. This time we only focus on two departments HHS and POL (Health and Human Services & Police department), and we want to have a sense of the gender distribution within these two departments.
#2. Clearly within HHS, the female male ratio is big with a female employee having the highest salary and a male employee having the lowest salary; however, in the police department, the female male ratio is small with a male employee having the highest salary and a female employee having the lowest salary.
#3. Altogether, there are more employees in HHS than in POL; the ranges of both departments are close around (225K - 23K = 202K)
#4. These observations are intuitive.

#Data Wrangling 3
df %>% select(X2014_OVERTIME_PAY, DEPARTMENT, GENDER) %>% filter(X2014_OVERTIME_PAY >= 10, DEPARTMENT %in% c("POL", "DOT", "DTS", "HHS", "FRS")) %>% group_by(GENDER) %>% ggplot(aes(x = DEPARTMENT, y = X2014_OVERTIME_PAY, color = GENDER)) + geom_point()
#Observations:
#1. First, this time we focus on 2014 OVERTIME PAY (additional financial compensation for any hours worked over the amount of 40 hours per week). Secondly, before I visualize the data, I exclude those employess whose over time pay is null. There are two reasons for null: one is that some of the employees have not had overtime working hours, and the other is that some employees indeed worked overtime during 2014 but did not get compensation. 
#2. We can clearly see that, the department that had the most employees worked overtime is the FRS (Florida Retirement System); within FRS, there were only few female employees who worked overtime and the majority is male. The department that had the least employees worked overtime is the DTS (Department of Technology Services); within the departmentt, only one female employee had worked overtime. The department that has the most female employees worked overtime is HHS, which is reasonable as we have seen before that this department has the most female employees among all 5 public departments
#3. The highest overtime pay is up to 100K and it lies in the FRS, and the lowest is down to almost 0.
