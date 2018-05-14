library(deSolve) # ode
library(ggplot2)
library(dplyr) # rename, %>% 
library(tidyr) # gather



##########
# beta = beta_0
####

model <- function(time, state, parameters) {
  with(as.list(c(state, parameters)), {
    dS = -b*S*I -a*S*D
    dE = b*S*I +a*S*D -s*E
    dI = s*E - g*I
    dR = (1-f)*g*I
    dD = f*g*I
    return(list(c(dS, dE, dI, dR, dD)))
  })
}

table <- ode(func = model,
           y = c(S=1000000, E=0, I=1, R=0, D=0), # stocks t=0
           parms = c(a=0, b=1.22e-06, s=1/9.31, g=1/7.41, f=0.39),
           times = seq(0, 100, by = 1)) %>% as.data.frame

table %>% 
  rename(susceptible=S, exposed=E, infectious=I, recovered=R, dead=D) %>% # rename(newname = oldname)
  gather(key="group", value="people", -time) %>% # long-format
  ggplot(aes(x=time, y=people, col=group)) +
    geom_line() +
    geom_point() +
    theme_minimal() +
    xlab("days") +
    theme(legend.title=element_blank())






##########
# beta = beta(t)
####

beta <- function(t, b, tau, k){
  ifelse(t < tau, b, b*exp(-k*(t-tau)))
}

# beta(t=c(0:100), b=1.22e-06, tau=3, k=0.19) %>% plot(type="l")

model <- function(time, state, parameters) {
  with(as.list(c(state, parameters)), {
    dS = -beta(time, b, tau, k)*S*I -a*S*D
    dE = beta(time, b, tau, k)*S*I +a*S*D -s*E
    dI = s*E - g*I
    dR = (1-f)*g*I
    dD = f*g*I
    return(list(c(dS, dE, dI, dR, dD)))
  })
}

table <- ode(func = model,
             y = c(S=1000000, E=0, I=1, R=0, D=0),
             parms = c(a=0, b=1.22e-06, s=1/9.31, g=1/7.41, f=0.39, tau=3, k=0.19),
             times = seq(0, 100, by = 1)) %>% as.data.frame

table %>% 
  rename(susceptible=S, exposed=E, infectious=I, recovered=R, dead=D) %>%
  select(-susceptible) %>%
  gather(key="group", value="people", -time) %>%
  ggplot(aes(x=time, y=people, col=group)) +
    geom_line() +
    geom_point() +
    theme_minimal() +
    xlab("days") +
    theme(legend.title=element_blank())
