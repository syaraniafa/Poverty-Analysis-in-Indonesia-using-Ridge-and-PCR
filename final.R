library(readxl)
library(lmtest)
library(nortest)
library(car)
library(ggthemes)


##load Dataset
datafinal <- read_excel("R Programming/RA-final/datafinal.xlsx")
#View(datafinal)

## data visuzualization 
library(ggplot2)

ggplot() + 
  aes(x=datafinal$Median_pendapatan_penduduk_dibawah40) +
  geom_histogram(fill = "lightblue", 
                 color = "black",
                 binwidth = 3) + 
  labs(y = "Count", 
       title = "Citizens under Median Poverty Line", 
       subtitle = "Distribusi dari Target Variable",
       x = "") + 
  theme_fivethirtyeight() + 
  theme(axis.title = element_text())


ggplot(datafinal, aes(Tingkat_kemiskinan_kota, Provinsi))+
  geom_bar(stat = "identity")+
  labs(title = "Tingkat Kemiskinan di berbagai Provinsi", 
       x = "Tingkat Kemiskinan di Perkotaan", y = "Provinsi") + 
  scale_x_log10()



ggplot(datafinal, aes(Gini_ratio, Provinsi))+
  geom_bar(stat = "identity",color = "red")+
  labs(title = "Scatter Plot Gini Ratio di berbagai Provinsi", 
       x = "Gini Ratio", y = "Provinsi")+
  scale_x_log10()


ggplot(datafinal, aes(Median_pendapatan_penduduk_dibawah40, Tingkat_penyelasaian_SMA)) +
  geom_point() +
  labs(title = "Korelasi Tingkat Penyelasaian SMA dengan Pendapatan dibawah 40%", 
       y = "Tingkat Penyelasaian SMA",
       x = "Median Pendapatan Penduduk dibawah 40%") + 
  theme_fivethirtyeight() + theme(axis.title = element_text())

## Base Model
m1 <- lm(Median_pendapatan_penduduk_dibawah40 ~ Tingkat_kemiskinan_kota+Gini_ratio+Tingkat_penyelasaian_SD
         +Tingkat_penyelasaian_SMP+Tingkat_penyelasaian_SMA+Buta_huruf_15_minus+Buta_huruf_15+Buta_huruf_45
         +Anak_bekerja+Tingkat_setengah_pengangguran+Tenaga_kerja_formal+Kerja_informal_pertanian
         +Upah_rata2_perjam+Konsumsi_kalori_perhari+Konsumsi_protein_perhari
         +GK_perkotaan+GK_non_makanan_kota+Tingkat_kerentanan_penduduk+kepemilikan_akta_40kebawah, data = datafinal)



summary(m1)$coefficients[,"Estimate"]


error <- resid(m1)
lillie.test(error)
dwtest(m1)
bptest(m1)
car::vif(m1)


####Pemodelan Baru

##Ridge
library(lmridge)
m2<-lmridge(Median_pendapatan_penduduk_dibawah40 ~ Tingkat_kemiskinan_kota+Gini_ratio+Tingkat_penyelasaian_SD
       +Tingkat_penyelasaian_SMP+Tingkat_penyelasaian_SMA+Buta_huruf_15_minus+Buta_huruf_15+Buta_huruf_45
       +Anak_bekerja+Tingkat_setengah_pengangguran+Tenaga_kerja_formal+Kerja_informal_pertanian
       +Upah_rata2_perjam+Konsumsi_kalori_perhari+Konsumsi_protein_perhari
       +GK_perkotaan+GK_non_makanan_kota+Tingkat_kerentanan_penduduk+kepemilikan_akta_40kebawah, data = datafinal)
ridge_summ <- summary(m2)

ridge_summ


##Principal Component Regression
library(pls)
set.seed(1)
m3<-pcr(Median_pendapatan_penduduk_dibawah40 ~ Tingkat_kemiskinan_kota+Gini_ratio+Tingkat_penyelasaian_SD
            +Tingkat_penyelasaian_SMP+Tingkat_penyelasaian_SMA+Buta_huruf_15_minus+Buta_huruf_15+Buta_huruf_45
            +Anak_bekerja+Tingkat_setengah_pengangguran+Tenaga_kerja_formal+Kerja_informal_pertanian
            +Upah_rata2_perjam+Konsumsi_kalori_perhari+Konsumsi_protein_perhari
            +GK_perkotaan+GK_non_makanan_kota+Tingkat_kerentanan_penduduk+kepemilikan_akta_40kebawah, data = datafinal, scale=TRUE, validation="CV")
 summary(m3)
pcr_summ1

validationplot(m3, val.type="R2", cex.axis=0.7)
axis(side = 1, at = c(5), cex.axis=0.7)
abline(v = 5, col = "blue", lty = 3)

validationplot(m3, val.type="MSEP", cex.axis=0.7)
axis(side = 1, at = c(5), cex.axis=0.7)
abline(v = 5 , col = "blue", lty = 3)



k = 5
set.seed(1)
m4<-pcr(Median_pendapatan_penduduk_dibawah40 ~ Tingkat_kemiskinan_kota+Gini_ratio+Tingkat_penyelasaian_SD
        +Tingkat_penyelasaian_SMP+Tingkat_penyelasaian_SMA+Buta_huruf_15_minus+Buta_huruf_15+Buta_huruf_45
        +Anak_bekerja+Tingkat_setengah_pengangguran+Tenaga_kerja_formal+Kerja_informal_pertanian
        +Upah_rata2_perjam+Konsumsi_kalori_perhari+Konsumsi_protein_perhari
        +GK_perkotaan+GK_non_makanan_kota+Tingkat_kerentanan_penduduk+kepemilikan_akta_40kebawah, data = datafinal, scale=TRUE, ncomp = k)
summary(m4)

m4$model
m4$scores
m4$projection
m4$loadings
#untuk model yang menggunakan coefisien dari PCR
coef(m4)

#Pemodelan dengan lm with new values
combined_data <- cbind(m4$scores, y = datafinal$Median_pendapatan_penduduk_dibawah40)
combined_data <- as.data.frame(combined_data)
head(combined_data)

m5 <- lm(y ~., data = combined_data)
summary(m5)


#Principal Component Analysis 2
z1 <- scale(datafinal$Tingkat_kemiskinan_kota)
z2 <- scale(datafinal$Gini_ratio)
z3 <- scale(datafinal$Tingkat_penyelasaian_SD)
z4 <- scale(datafinal$Tingkat_penyelasaian_SMP)
z5 <- scale(datafinal$Tingkat_penyelasaian_SMA)
z6 <- scale(datafinal$Buta_huruf_15)
z7 <- scale(datafinal$Buta_huruf_15_minus)
z8 <- scale(datafinal$Buta_huruf_45)
z9 <- scale(datafinal$Anak_bekerja)
z10 <- scale(datafinal$Tingkat_setengah_pengangguran)
z11 <- scale(datafinal$Tenaga_kerja_formal)
z12 <- scale(datafinal$Kerja_informal_pertanian)
z13 <- scale(datafinal$Lapangan_kerja_informal)
z14 <- scale(datafinal$Upah_rata2_perjam)
z15 <- scale(datafinal$Konsumsi_kalori_perhari)
z16 <- scale(datafinal$Konsumsi_protein_perhari)
z17 <- scale(datafinal$GK_perkotaan)
z18 <- scale(datafinal$GK_non_makanan_kota)
z19 <- scale(datafinal$Tingkat_kerentanan_penduduk)
z20 <- scale(datafinal$kepemilikan_akta_40kebawah)

standardized_data <- cbind(z1,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11,z12,z13,z14,z15,z16,z17,z18,z19,z20)
eigen(cov(standardized_data))

pcaKS <- princomp(standardized_data, cor = T, scores = T)
summary(pcaKS)

pcaKS$loadings
##menggunakan yang componentnya 5
m6coef <- pcaKS$loadings[,5]
m6coef
m6X <- m6coef[1] * z1 + m6coef[2] * z2 + m6coef[5] * z5 + m6coef[6] * z6  + m6coef[8] * z8  + m6coef[9] * z9 + m6coef[10] * z10 + m6coef[14] * z14 + m6coef[15] * z15 + m6coef[16] * z16 + m6coef[19] * z19 + m6coef[20] * z20
y <- datafinal$Median_pendapatan_penduduk_dibawah40

m6X


mean(z20)
sd(z20)

m6 <- lm(y~m6X)
summary(m6)
#model yang menggunakan PCR
beta0PC <- summary(m6)$coef[1]
beta1PC <- summary(m6)$coef[2]


yPC <- beta0PC + beta1PC * m6X
yPC
