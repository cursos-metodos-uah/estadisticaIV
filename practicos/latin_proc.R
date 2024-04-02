
pacman::p_load(dplyr, sjmisc, car, sjlabelled, stargazer, haven)
rm(list=ls())       # borrar todos los objetos en el espacio de trabajo
options(scipen=999) # valores sin notación científica

load(url("https://github.com/Kevin-carrasco/metod1-MCS/raw/main/files/data/external_data/latinobarometro2020.RData"))
proc_data <- latinobarometro2020 %>% select(p13st_e, # Confianza en el Gobierno
                                            p13st_d, # Confianza en el congreso
                                            p13st_f, # Confianza en el Poder Judicial
                                            p13st_g, # Confianza en los partidos políticos
                                            reeduc_1,# nivel educacional
                                            sexo,# sexo
                                            edad,# edad
                                            idenpa) # pais

# Comprobar
names(proc_data)

proc_data$p13st_e <- recode(proc_data$p13st_e, "c(-2,-1)=NA")
proc_data$p13st_d <- recode(proc_data$p13st_d, "c(-2,-1)=NA")
proc_data$p13st_f <- recode(proc_data$p13st_f, "c(-2,-1)=NA")
proc_data$p13st_g <- recode(proc_data$p13st_g, "c(-2,-1)=NA")

proc_data$p13st_e <- recode(proc_data$p13st_e, "1=3; 2=2; 3=1; 4=0")
proc_data$p13st_d <- recode(proc_data$p13st_d, "1=3; 2=2; 3=1; 4=0")
proc_data$p13st_f <- recode(proc_data$p13st_f, "1=3; 2=2; 3=1; 4=0")
proc_data$p13st_g <- recode(proc_data$p13st_g, "1=3; 2=2; 3=1; 4=0")

proc_data <- proc_data %>% rename("conf_gob"=p13st_e, # Confianza en el gobierno
                                  "conf_cong"=p13st_d, # Confianza en el congreso
                                  "conf_jud"=p13st_f, # Confianza en el Poder Judicial
                                  "conf_partpol"=p13st_g) # Confianza en los partidos políticos

proc_data$conf_gob <- set_label(x = proc_data$conf_gob,label = "Confianza: Gobierno")
get_label(proc_data$conf_gob)

proc_data$conf_cong  <- set_label(x = proc_data$conf_cong, label = "Confianza: Congreso")
get_label(proc_data$conf_cong)

proc_data$conf_jud  <- set_label(x = proc_data$conf_jud, label = "Confianza: Poder judicial")
get_label(proc_data$conf_jud)

proc_data$conf_partpol  <- set_label(x = proc_data$conf_partpol, label = "Confianza: Partidos politicos")
get_label(proc_data$conf_partpol)

proc_data$conf_inst <- (proc_data$conf_gob+proc_data$conf_cong+proc_data$conf_jud+proc_data$conf_partpol)
summary(proc_data$conf_inst)
proc_data$conf_inst  <- set_label(x = proc_data$conf_inst, label = "Confianza en instituciones")

proc_data$conf_gob <- set_labels(proc_data$conf_gob,
                                 labels=c( "Ninguna"=0,
                                           "Poca"=1,
                                           "Algo"=2,
                                           "Mucha"=3))

proc_data$conf_cong <- set_labels(proc_data$conf_cong,
                                  labels=c( "Ninguna"=0,
                                            "Poca"=1,
                                            "Algo"=2,
                                            "Mucha"=3))

proc_data$conf_jud <- set_labels(proc_data$conf_jud,
                                 labels=c( "Ninguna"=0,
                                           "Poca"=1,
                                           "Algo"=2,
                                           "Mucha"=3))

proc_data$conf_partpol <- set_labels(proc_data$conf_partpol,
                                     labels=c( "Ninguna"=0,
                                               "Poca"=1,
                                               "Algo"=2,
                                               "Mucha"=3))


proc_data$reeduc_1 <- car::recode(proc_data$reeduc_1, "c(1,2,3)=1; c(4,5)=2; c(6,7)=3")

proc_data$reeduc_1 <- factor(proc_data$reeduc_1,
                             labels = c("Educacion basica", "Educacion media", "Educacion superior"),
                             levels = c(1, 2, 3))

proc_data <- rename(proc_data,"educacion"=reeduc_1)

proc_data$educacion <- set_label(x = proc_data$educacion,label = "Educación")

proc_data$sexo <- car::recode(proc_data$sexo, "1=0;2=1")

proc_data$sexo <- factor(proc_data$sexo,
                         labels=c( "Hombre",
                                   "Mujer"),
                         levels=c(0,1))


proc_data$sexo <- set_label(x = proc_data$sexo,label = "Sexo")
get_label(proc_data$edad)
proc_data$edad <- set_label(x = proc_data$edad,label = "Edad")
proc_data <- as.data.frame(proc_data)

save(proc_data,file = "files/data/latinobarometro_total.RData")


