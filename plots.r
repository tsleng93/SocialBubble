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

########################
#read in data
########################
read.csv("HHs.csv") -> dt
read.csv("HH.csv") %>% 
  melt(id = "Household.size") -> dt
read.csv("Tab_RimpactMain.csv") %>%
  select(-(12:17)) %>%                            
  rbind(read.csv("Tab_DimpactMain.csv")) %>% 
  mutate(Outcome = gsub("Disease incidence increase","Increase in fatalities",Outcome)) -> dt.res    


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
  filter(Parameter.set == "LSHTM" & 
           R_init == .8 &
           Mean.field.assumption == "Household" &
           Compliance == "Compliance") %>%
  mutate(TauB = fct_relevel(TauB, "identical", "half", "small")) -> dt.mainres

hline.dat <- data.frame(Outcome = c("Net Reproduction Number","Net Reproduction Number","Increase in fatalities"),
                        threshold = c(.8,1,1))
  
my_breaks <- function(x) { if (max(x) < 5) c(.8,1,1.2,1.4,1.6,1.8,2) else c(1,2,3,5,10,20,30,50) }

dt.mainres %>% 
  ggplot(aes(x=Scenario, y=value, ymin=value.lo, ymax=value.hi, color=TauB)) +
    geom_hline(data = hline.dat, aes(yintercept = threshold), color = "grey", alpha=0.5, lty="dashed", lwd=1.15) +  
    geom_linerange(position = position_dodge(.5)) +
    geom_point(position = position_dodge(.5)) +
    labs(x="", y="", color="Infection rate in\nthe bubble relative\nto houshold")+
    scale_color_manual(values = c("#d1720490","#bab5b3","#2748e890")) +
    theme_light() + theme(legend.position = c(0.9, 0.6),
                          legend.background = element_rect(fill=alpha('white', 0.7)),
                          legend.title=element_text(size=9)) + 
    coord_flip() +
    scale_y_log10(breaks = my_breaks)+
    facet_grid(.~Outcome, scales = "free_x") +
    scale_x_discrete(labels = c("C1: Comparator 1\nstatus quo:\nno social bubbles",
                                "C2: Comparator 2\n33 percent increase\n their random contacts",
                                "1: Households with\nprimary school age\nchildren pair up",
                                "2: Households with\nchildren of any age\n pair up",
                                "3: Single occupancy\nhouseholds pair up",
                                "4: Single occupancy\nhouseholds pair up\nwith random household",
                                "5: Scenarios 1 and 3\ncombined",
                                "6: All households\npair up randomly"
                                ))
ggsave("main_results.pdf", units = "cm", width = 18, height = 12)

########################
#plot Tornado
########################
for(i in 1){
  data.frame(list(Outcome=NA, 
                  Scenario=NA, 
                  val.lo=1, 
                  val=1, 
                  val.hi=1)) %>%
    rbind(c("Net Reproduction Number","tauB",
            dt.res %>% filter(Scenario==i, Outcome=="Net Reproduction Number", Parameter.set=="LSHTM", Compliance=="Compliance", Mean.field.assumption=="Household",R_init==.8, TauB=="small") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Net Reproduction Number", Parameter.set=="LSHTM", Compliance=="Compliance", Mean.field.assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Net Reproduction Number", Parameter.set=="LSHTM", Compliance=="Compliance", Mean.field.assumption=="Household",R_init==.8, TauB=="identical") %>% select(value) %>% as.numeric())) %>%
    rbind(c("Net Reproduction Number","SAR",
            dt.res %>% filter(Scenario==i, Outcome=="Net Reproduction Number", Parameter.set=="LSHTM", Compliance=="Compliance", Mean.field.assumption=="Household",R_init==.8, TauB=="half") %>% select(value.lo) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Net Reproduction Number", Parameter.set=="LSHTM", Compliance=="Compliance", Mean.field.assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Net Reproduction Number", Parameter.set=="LSHTM", Compliance=="Compliance", Mean.field.assumption=="Household",R_init==.8, TauB=="half") %>% select(value.hi) %>% as.numeric())) %>%
    rbind(c("Net Reproduction Number","SusTrans",
            dt.res %>% filter(Scenario==i, Outcome=="Net Reproduction Number", Parameter.set=="Warwick", Compliance=="Compliance", Mean.field.assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Net Reproduction Number", Parameter.set=="LSHTM", Compliance=="Compliance", Mean.field.assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric(),
            NA)) %>%
    rbind(c("Net Reproduction Number","CommTrans",
            NA,
            dt.res %>% filter(Scenario==i, Outcome=="Net Reproduction Number", Parameter.set=="LSHTM", Compliance=="Compliance", Mean.field.assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Net Reproduction Number", Parameter.set=="LSHTM", Compliance=="Compliance", Mean.field.assumption=="Individual",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric())) %>%
    rbind(c("Net Reproduction Number","Compliance",
            NA,
            dt.res %>% filter(Scenario==i, Outcome=="Net Reproduction Number", Parameter.set=="LSHTM", Compliance=="Compliance", Mean.field.assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Net Reproduction Number", Parameter.set=="LSHTM", Compliance=="Non-compliance", Mean.field.assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric())) %>% 
    rbind(c("Net Reproduction Number","Rinit",
            dt.res %>% filter(Scenario==i, Outcome=="Net Reproduction Number", Parameter.set=="LSHTM", Compliance=="Compliance", Mean.field.assumption=="Household",R_init==.7, TauB=="half") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Net Reproduction Number", Parameter.set=="LSHTM", Compliance=="Compliance", Mean.field.assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Net Reproduction Number", Parameter.set=="LSHTM", Compliance=="Compliance", Mean.field.assumption=="Household",R_init==.9, TauB=="half") %>% select(value) %>% as.numeric())) %>%
    rbind(c("Increase in fatalities","tauB",
            dt.res %>% filter(Scenario==i, Outcome=="Increase in fatalities", Parameter.set=="LSHTM", Compliance=="Compliance", Mean.field.assumption=="Household",R_init==.8, TauB=="small") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Increase in fatalities", Parameter.set=="LSHTM", Compliance=="Compliance", Mean.field.assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Increase in fatalities", Parameter.set=="LSHTM", Compliance=="Compliance", Mean.field.assumption=="Household",R_init==.8, TauB=="identical") %>% select(value) %>% as.numeric())) %>%
    rbind(c("Increase in fatalities","SAR",
            dt.res %>% filter(Scenario==i, Outcome=="Increase in fatalities", Parameter.set=="LSHTM", Compliance=="Compliance", Mean.field.assumption=="Household",R_init==.8, TauB=="half") %>% select(value.lo) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Increase in fatalities", Parameter.set=="LSHTM", Compliance=="Compliance", Mean.field.assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Increase in fatalities", Parameter.set=="LSHTM", Compliance=="Compliance", Mean.field.assumption=="Household",R_init==.8, TauB=="half") %>% select(value.hi) %>% as.numeric())) %>%
    rbind(c("Increase in fatalities","SusTrans",
            dt.res %>% filter(Scenario==i, Outcome=="Increase in fatalities", Parameter.set=="Warwick", Compliance=="Compliance", Mean.field.assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Increase in fatalities", Parameter.set=="LSHTM", Compliance=="Compliance", Mean.field.assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric(),
            NA)) %>%
    rbind(c("Increase in fatalities","CommTrans",
            NA,
            dt.res %>% filter(Scenario==i, Outcome=="Increase in fatalities", Parameter.set=="LSHTM", Compliance=="Compliance", Mean.field.assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Increase in fatalities", Parameter.set=="LSHTM", Compliance=="Compliance", Mean.field.assumption=="Individual",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric())) %>%
    rbind(c("Increase in fatalities","Compliance",
            NA,
            dt.res %>% filter(Scenario==i, Outcome=="Increase in fatalities", Parameter.set=="LSHTM", Compliance=="Compliance", Mean.field.assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Increase in fatalities", Parameter.set=="LSHTM", Compliance=="Non-compliance", Mean.field.assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric())) %>%
    rbind(c("Increase in fatalities","Rinit",
            dt.res %>% filter(Scenario==i, Outcome=="Increase in fatalities", Parameter.set=="LSHTM", Compliance=="Compliance", Mean.field.assumption=="Household",R_init==.7, TauB=="half") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Increase in fatalities", Parameter.set=="LSHTM", Compliance=="Compliance", Mean.field.assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% as.numeric(),
            dt.res %>% filter(Scenario==i, Outcome=="Increase in fatalities", Parameter.set=="LSHTM", Compliance=="Compliance", Mean.field.assumption=="Household",R_init==.9, TauB=="half") %>% select(value) %>% as.numeric())) %>%
    slice(-1) -> dt.tornado
  
  hline.dat <- data.frame(Outcome = c("Net Reproduction Number","Increase in fatalities"),
                          value = dt.res %>% filter(Scenario==i, Parameter.set=="LSHTM", Compliance=="Compliance", Mean.field.assumption=="Household",R_init==.8, TauB=="half") %>% select(value) %>% c())
  my_breaks <- function(x) { if (max(x) > 2.5) c(1.1,1.33,round(hline.dat[2,2],2),1.66,2,2.33) else c(0.75,.8,round(hline.dat[1,2],2),.9,.95,1,1.1) }
  
  dt.tornado %>%
    ggplot(aes(x = Scenario)) +
    geom_hline(data = hline.dat, aes(yintercept = value), color = "grey", alpha=0.8, lty="dashed", lwd=1.15) +
      geom_linerange(aes(ymin=as.numeric(val), ymax=as.numeric(val.hi)), color="#d17204", lwd=12, alpha=.6)+
      geom_linerange(aes(ymin=as.numeric(val.lo), ymax=as.numeric(val)), color="#2748e8", lwd=12, alpha=.6)+
      facet_grid(.~Outcome, scales = "free")+
      coord_flip() +
      xlab("")+
      theme_light()+
      scale_x_discrete(labels = c("Community\ntransmission",
                                  "Adherence",
                                  "Current net\nreproduction number",
                                  "Household\nattack rate",
                                  "Susceptibility and\ninfectivity",
                                  "Transmissibility\nwithin bubbles")) +
    scale_y_log10(breaks = my_breaks)
  ggsave(paste0("main_tornado_Scenario_",i,".pdf"), units = "cm", width = 17, height = 8)
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

