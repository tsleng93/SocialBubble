#########
# plotting scripts 
# for "The effectiveness of social bubbles as part of a Covid-19 lockdown exit strategy, a modelling study"
# by Leng et al
# author: Stefan Flasche


########################
#load packages
########################
require(reshape2)
require(tidyverse)
require(gridExtra)

########################
#read in data
########################
read.csv("HH.csv") %>% 
  melt(id = "Household.size") -> dt
read.csv("Tab_Rcurrent.csv") %>%
  select(-(12:14)) %>%                            
  rbind(read.csv("Tab_Dcurrent.csv") %>%
          mutate(Outcome = "Disease incidence increase")) %>% 
  mutate(Outcome = gsub("Disease incidence increase","Increase in fatalities",Outcome)) %>%
  mutate(Outcome = gsub("Fatality Incidence Increase","Increase in fatalities",Outcome))->  dt.res    


########################
#plot Household sizes
########################
# av HH size
dt %>%
  group_by(variable) %>% summarise(avHHsize=sum(Household.size*value)/sum(value))

# proportion of HHs
dt %>%
  mutate(People = Household.size*value) %>%
  group_by(variable) %>% summarise(value= sum(value),
                                   People = sum(People))

#refactor
dt$variable = factor(dt$variable, c("All", "Children..20", "Children..10"))
Cat.names.replace = c("All"="All\nhouseholds", "Children..20"="Households with\n <20y old Child", "Children..10"="Households with\n <10y old Child")
Cat.names=c("All households", "Households with <20y old Child", "Households with <10y old Child")

# plot
dt %>%
  ggplot(aes(x=Household.size,y=value/1000000, fill=variable)) +
  geom_bar(stat = "identity", alpha=.6, position=position_dodge(width = .5), width = 1.8, color = "white") +
  scale_fill_manual(labels = Cat.names,
                    values=c("#1677a1","#54a4c7", "#a7dbf2")) +
  labs(x = "Household size", y = "Number of households\n(in 1,000,000s)", fill="") + 
  theme_classic() + theme(legend.position = c(0.7, 0.8))
ggsave("main_HHdistr.pdf", units = "cm", width = 14, height = 10)


########################
#plot Rs and deaths
########################
#filter for only the base case results
dt.res %>%
  filter(Parameter_set == "LSHTM" & 
           R_init == .8 &
           Mean_field_assumption == "Household" &
           Compliance == "Compliance") %>%
  mutate(TauB = fct_relevel(TauB, "identical", "half", "small")) -> dt.mainres

hline.dat <- data.frame(Outcome = c("Net Reproduction Number","Net Reproduction Number","Increase in fatalities"),
                        threshold = c(.8,1,1))

my_breaks <- function(x) { if (max(x) < 5) c(.8,1,1.2,1.4,1.6,1.8,2,2.2) else c(1,2,4,8,16,32,64,128) }

dt.mainres$Scenario = factor(dt.mainres$Scenario, c("C1", "C2", "C3","1", "2","3","4","5","6"))


dt.mainres %>% 
  ggplot(aes(x=Scenario, y=value, ymin=value_lo, ymax=value_hi, color=TauB)) +
  geom_hline(data = hline.dat, aes(yintercept = threshold), color = "grey", alpha=0.5, lty="dashed", lwd=1.15) +  
  geom_linerange(position = position_dodge(.5)) +
  geom_point(position = position_dodge(.5)) +
  labs(x="", y="", color="Transmission rate in\nthe bubble relative\nto household")+
  scale_color_manual(values = c("#d1720490","#bab5b3","#2748e890"),
                     labels = c("identical (100%)", "half (50%)", "small (10%)" )) +
  theme_light() + theme(legend.position = c(0.87, 0.65),
                        legend.background = element_rect(fill=alpha('white', 0.7)),
                        legend.title=element_text(size=9)) + 
  coord_flip() +
  scale_y_log10(breaks = my_breaks)+
  facet_grid(.~Outcome, scales = "free_x") +
  scale_x_discrete(labels = c("Scenario C1:\n(no social bubbles)",
                              "Scenario C2:\n(fixed random\ncontacts)",
                              "Scenario C3:\n(varying random\ncontacts)",
                              "Scenario 1:\n(young children)",
                              "Scenario 2:\n(children))",
                              "Scenario 3:\n(Single households)",
                              "Scenario 4:\n(1 adult households\nwith any)",
                              "Scenario 5:\n(Scenarios 1 and 3\ncombined)",
                              "Scenario 6:\n(All households)"))
ggsave("main_results.pdf", units = "cm", width = 18, height = 12)


########################
#extract effectiveness of bubbles
########################

dt.res %>% 
  gather(SAR, value, -(Outcome:Scenario_lab)) %>%
  select(-c("Scenario_lab")) %>%
  filter(Scenario %in% c("C1","C2","C3","6")) %>%
  spread(Scenario,value) %>%
  mutate(C2Increase = 1-`6`/`C2`,
         C3Increase = 1-`6`/`C3`) -> dt.eff

dt.eff %>%
  filter(Parameter_set %in% c("LSHTM","Warwick") & 
           R_init == .8 &
           Mean_field_assumption == "Household" &
           Compliance == "Compliance" &
           Outcome == "Increase in fatalities" &
           SAR == "value" &
           TauB == "half")


########################
#plot Tornado
########################
for(i in c("1","2","3","4","5","6","C2","C3")){
  data.frame(list(Outcome=NA, 
                  Scenario=NA, 
                  val.lo=1, 
                  val=1, 
                  val.hi=1)) %>%
    rbind(c("Net Reproduction Number","tauB",
            dt.res %>% filter(Scenario==i, Outcome=="Net Reproduction Number", Parameter_set=="LSHTM", Compliance=="Compliance", Mean_field_assumption=="Household",R_init==.8, TauB=="small") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Net Reproduction Number", Parameter_set=="LSHTM", Compliance=="Compliance", Mean_field_assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Net Reproduction Number", Parameter_set=="LSHTM", Compliance=="Compliance", Mean_field_assumption=="Household",R_init==.8, TauB=="identical") %>% select(value) %>% as.numeric())) %>%
    rbind(c("Net Reproduction Number","SAR",
            dt.res %>% filter(Scenario==i, Outcome=="Net Reproduction Number", Parameter_set=="LSHTM", Compliance=="Compliance", Mean_field_assumption=="Household",R_init==.8, TauB=="half") %>% select(value_lo) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Net Reproduction Number", Parameter_set=="LSHTM", Compliance=="Compliance", Mean_field_assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Net Reproduction Number", Parameter_set=="LSHTM", Compliance=="Compliance", Mean_field_assumption=="Household",R_init==.8, TauB=="half") %>% select(value_hi) %>% as.numeric())) %>%
    rbind(c("Net Reproduction Number","SusTrans",
            dt.res %>% filter(Scenario==i, Outcome=="Net Reproduction Number", Parameter_set=="Warwick", Compliance=="Compliance", Mean_field_assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Net Reproduction Number", Parameter_set=="LSHTM", Compliance=="Compliance", Mean_field_assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric(),
            NA)) %>%
    rbind(c("Net Reproduction Number","CommTrans",
            NA,
            dt.res %>% filter(Scenario==i, Outcome=="Net Reproduction Number", Parameter_set=="LSHTM", Compliance=="Compliance", Mean_field_assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Net Reproduction Number", Parameter_set=="LSHTM", Compliance=="Compliance", Mean_field_assumption=="Individual",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric())) %>%
    rbind(c("Net Reproduction Number","Compliance",
            NA,
            dt.res %>% filter(Scenario==i, Outcome=="Net Reproduction Number", Parameter_set=="LSHTM", Compliance=="Compliance", Mean_field_assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Net Reproduction Number", Parameter_set=="LSHTM", Compliance=="Non-compliance", Mean_field_assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric())) %>% 
    rbind(c("Net Reproduction Number","Excluding Elderly",
            dt.res %>% filter(Scenario==i, Outcome=="Net Reproduction Number", Parameter_set=="LSHTM", Compliance=="Excluding Elderly", Mean_field_assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Net Reproduction Number", Parameter_set=="LSHTM", Compliance=="Compliance", Mean_field_assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric())) %>%
    rbind(c("Net Reproduction Number","Rinit",
            dt.res %>% filter(Scenario==i, Outcome=="Net Reproduction Number", Parameter_set=="LSHTM", Compliance=="Compliance", Mean_field_assumption=="Household",R_init==.7, TauB=="half") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Net Reproduction Number", Parameter_set=="LSHTM", Compliance=="Compliance", Mean_field_assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Net Reproduction Number", Parameter_set=="LSHTM", Compliance=="Compliance", Mean_field_assumption=="Household",R_init==.9, TauB=="half") %>% select(value) %>% as.numeric(),
            NA)) %>%
    rbind(c("Increase in fatalities","tauB",
            dt.res %>% filter(Scenario==i, Outcome=="Increase in fatalities", Parameter_set=="LSHTM", Compliance=="Compliance", Mean_field_assumption=="Household",R_init==.8, TauB=="small") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Increase in fatalities", Parameter_set=="LSHTM", Compliance=="Compliance", Mean_field_assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Increase in fatalities", Parameter_set=="LSHTM", Compliance=="Compliance", Mean_field_assumption=="Household",R_init==.8, TauB=="identical") %>% select(value) %>% as.numeric())) %>%
    rbind(c("Increase in fatalities","SAR",
            dt.res %>% filter(Scenario==i, Outcome=="Increase in fatalities", Parameter_set=="LSHTM", Compliance=="Compliance", Mean_field_assumption=="Household",R_init==.8, TauB=="half") %>% select(value_lo) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Increase in fatalities", Parameter_set=="LSHTM", Compliance=="Compliance", Mean_field_assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Increase in fatalities", Parameter_set=="LSHTM", Compliance=="Compliance", Mean_field_assumption=="Household",R_init==.8, TauB=="half") %>% select(value_hi) %>% as.numeric())) %>%
    rbind(c("Increase in fatalities","SusTrans",
            dt.res %>% filter(Scenario==i, Outcome=="Increase in fatalities", Parameter_set=="Warwick", Compliance=="Compliance", Mean_field_assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Increase in fatalities", Parameter_set=="LSHTM", Compliance=="Compliance", Mean_field_assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric(),
            NA)) %>%
    rbind(c("Increase in fatalities","CommTrans",
            NA,
            dt.res %>% filter(Scenario==i, Outcome=="Increase in fatalities", Parameter_set=="LSHTM", Compliance=="Compliance", Mean_field_assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Increase in fatalities", Parameter_set=="LSHTM", Compliance=="Compliance", Mean_field_assumption=="Individual",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric())) %>%
    rbind(c("Increase in fatalities","Compliance",
            NA,
            dt.res %>% filter(Scenario==i, Outcome=="Increase in fatalities", Parameter_set=="LSHTM", Compliance=="Compliance", Mean_field_assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Increase in fatalities", Parameter_set=="LSHTM", Compliance=="Non-compliance", Mean_field_assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric())) %>%
    rbind(c("Increase in fatalities","Excluding Elderly",
            dt.res %>% filter(Scenario==i, Outcome=="Increase in fatalities", Parameter_set=="LSHTM", Compliance=="Excluding Elderly", Mean_field_assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Increase in fatalities", Parameter_set=="LSHTM", Compliance=="Compliance", Mean_field_assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric(),
            NA)) %>%
    rbind(c("Increase in fatalities","Rinit",
            dt.res %>% filter(Scenario==i, Outcome=="Increase in fatalities", Parameter_set=="LSHTM", Compliance=="Compliance", Mean_field_assumption=="Household",R_init==.9, TauB=="half") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Increase in fatalities", Parameter_set=="LSHTM", Compliance=="Compliance", Mean_field_assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Increase in fatalities", Parameter_set=="LSHTM", Compliance=="Compliance", Mean_field_assumption=="Household",R_init==.7, TauB=="half") %>% select(value) %>% as.numeric())) %>%
    slice(-1) -> dt.tornado
  
  hline.dat <- data.frame(Outcome = c("Net Reproduction Number","Increase in fatalities"),
                          value = dt.res %>% filter(Scenario==i, Parameter_set=="LSHTM", Compliance=="Compliance", Mean_field_assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% c())
  my_breaks <- function(x) { if (max(x) > 8) c(1, 2, 4, 8, 16, 32) else if (max(x) > 3) c(1,2,3,4,5,6,7,8) else if (max(x) > 2) c(1, 1.2, 1.6, 2.0, 2.4) else if (max(x) > 1.5) c(1, 1.2, 1.4, 1.6, 1.8) else if (max(x) > 1.1) c(0.8, 0.9, 1.0, 1.1, 1.2, 1.3, 1.4) else c(0.7, 0.75, 0.8, 0.85, 0.9, 0.95, 1, 1.05, 1.1, 1.2, 1.4, 1.6) }
  my_labs <- c("Community\ntransmission",
               "Adherence",
               "Excluding households \n with adults > 70 ",
               "Current net\nreproduction number",
               "Household\nattack rate",
               "Susceptibility and\ninfectivity",
               "Transmissibility\nwithin bubbles")
  
  if(i %in% c("C2", "C3")){
    dt.tornado %>%
      filter(Scenario != "Compliance") -> dt.tornado
    
    dt.tornado %>%
      filter(Scenario != "Excluding Elderly") -> dt.tornado
    
    my_labs = my_labs[-2]
    my_labs = my_labs[-2]
  }
  
  dt.tornado %>%
    ggplot(aes(x = Scenario)) +
    geom_hline(data = hline.dat, aes(yintercept = value), color = "grey", alpha=0.8, lty="dashed", lwd=1.15) +
    geom_linerange(aes(ymin=as.numeric(val), ymax=as.numeric(val.hi)), color="#d17204", lwd=12, alpha=.6)+
    geom_linerange(aes(ymin=as.numeric(val.lo), ymax=as.numeric(val)), color="#2748e8", lwd=12, alpha=.6)+
    facet_grid(.~Outcome, scales = "free")+
    coord_flip() +
    xlab("")+
    theme_light()+
    scale_x_discrete(labels = my_labs) +
    scale_y_log10(breaks = my_breaks)
  ggsave(paste0("main_tornado_Scenario_",i,".pdf"), units = "cm", width = 17, height = 8.5)
}



########################
# create contact matrix for plotting
########################
N=80
Nh=4
p=1/5
p2=1/3
M1 = matrix(rep(1/N,N^2),N) #community
M2 = matrix(rep(0,N^2),N) # HH
M3 = matrix(rep(0,N^2),N) # bubble
i=1
HHsize=Nh
c="tick"
Bsize=NULL
while((i+HHsize-1)<=N){
  M2[i:(i+HHsize-1),i:(i+HHsize-1)] = p
  i=i+HHsize
  if (c=="tick"){
    c="toc"
    Bsize=c(Bsize,HHsize)
  }else{
    c="tick"
    Bsize[length(Bsize)] = Bsize[length(Bsize)]+HHsize
  }
  HHsize = sample(2:6,1)
}
BBsize = cumsum(Bsize)
BBsize.lo = c(1,BBsize[1:(length(BBsize)-1)]+1)
for (i in 1:length(BBsize)){
  M3[BBsize.lo[i]:BBsize[i],BBsize.lo[i]:BBsize[i]] = p2
}

M=M1+M2+M3 
diag(M)=0
rotate <- function(x) t(apply(x, 2, rev))

#display matrix
plot=T
if(plot){
  M %>% 
    rotate() %>%
    melt() %>%
    ggplot(aes(x=Var1, y=Var2, fill=as.character(value))) +
    geom_raster() +
    theme_void() +
    labs(x="", y="", fill="") +
    scale_fill_manual(values=c("white","#f2f4f599","#28ebca99","#24a5d199"),
                      labels = c("","community","within\nbubble","within\nhousehold")) +
    theme(legend.position = "bottom")
}
ggsave("main_bubblematrix.pdf", units = "cm", width = 11, height = 12)



########################
# Plot fatality equity
########################

read.csv("Fatality_increase_current.csv") %>%
  melt(id="Scenario") -> dt.fat

dt.fat %>%
  filter(variable %in% c("K_over_M", "L_over_N")) %>%
  ggplot(aes(x=Scenario, y=value, fill=variable)) +
  geom_bar(stat="identity", position = position_dodge(.7), alpha=.6, color="white") +
  scale_y_log10() +
  scale_fill_manual(labels=c("eligible","not eligible"),
                    values=c("#2748e8","#d17204"))+
  scale_x_discrete(labels = c("Scenario 1:\n(young children)",
                              "Scenario 2:\n(children))",
                              "Scenario 3:\n(Single households)",
                              "Scenario 4:\n(1 adult households\nwith any)",
                              "Scenario 5:\n(Scenarios 1 and 3\ncombined)",
                              "Scenario 6:\n(All households)")) +
  coord_flip()+
  labs(x="",
       y="Relative risks for infection compared to eligible / not eligible\nhousholds in scenario C1 (status quo)",
       fill="Household eligibility\nfor forming social bubbles") +
  theme_light() + theme(legend.position = c(0.8, 0.3),
                        legend.background = element_rect(fill=alpha('white', 0.7)),
                        legend.title=element_text(size=9)) -> p1

dt.fat %>%
  filter(variable %in% c("PAF_B", "PAF_C","PAF_C1")) %>%
  ggplot(aes(x=Scenario, y=value, fill=variable)) +
  geom_bar(stat="identity", position = position_dodge(.7), alpha=.6, color="white") +
  scale_fill_manual(labels=c("excess in\neligible households","excess in not\neligible households","baseline"),
                    values=c("#2748e8","#d17204","grey"))+
  scale_x_discrete(labels = c("",
                              "",
                              "",
                              "",
                              "",
                              "")) +
  scale_y_continuous(labels = scales::percent) +
  coord_flip()+
  labs(x="",
       y="Percentage of fatalities\n ",
       fill="Fatalities") +
  theme_light() + theme(legend.position = c(0.8, 0.3),
                        legend.background = element_rect(fill=alpha('white', 0.7)),
                        legend.title=element_text(size=9)) -> p2

grid.arrange(p1,p2,nrow=1, widths=c(1,0.75)) -> p3
ggsave("main_fatalityequity.pdf", p3, units = "cm", width = 24, height = 10)
