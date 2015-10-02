#Data Wrangling 1
df %>% select(CURRENT_ANNUAL_SALARY, DEPARTMENT, POSITION_TITLE) %>% filter(CURRENT_ANNUAL_SALARY >= 80000, DEPARTMENT %in% c("POL", "DOT", "DTS", "HHS", "FRS")) %>% ggplot(aes(x = POSITION_TITLE, y = CURRENT_ANNUAL_SALARY, color = DEPARTMENT)) + geom_point()

#Data Wrangling 2
df %>% select(CURRENT_ANNUAL_SALARY, DEPARTMENT, GENDER) %>% group_by(GENDER) %>% filter(DEPARTMENT %in% c("POL","HHS")) %>% ggplot(aes(x = DEPARTMENT, y = CURRENT_ANNUAL_SALARY, color = GENDER)) + geom_point()

#Data Wrangling 3
df %>% select(X2014_OVERTIME_PAY, DEPARTMENT, GENDER) %>% filter(X2014_OVERTIME_PAY >= 10, DEPARTMENT %in% c("POL", "DOT", "DTS", "HHS", "FRS")) %>% group_by(GENDER) %>% ggplot(aes(x = DEPARTMENT, y = X2014_OVERTIME_PAY, color = GENDER)) + geom_point()