# Figura da distribuição de Ozone por mês

dados <- read.csv("airquality.csv")

pdf("figura.pdf")

par(mfrow = c(2, 2))

# Boxplot de Ozone por mês
boxplot(
  Ozone ~ Month,
  data = dados,
  main = "Distribuição de Ozone por mês",
  xlab = "Mês",
  ylab = "Ozone"
)

# Densidades de Ozone por mês
meses <- sort(unique(dados$Month))

plot(
  NULL,
  xlim = range(dados$Ozone, na.rm = TRUE),
  ylim = c(0, 0.08),
  xlab = "Ozone",
  ylab = "Densidade",
  main = "Densidade de Ozone por mês"
)

for (mes in meses) {
  valores <- dados$Ozone[dados$Month == mes]
  valores <- valores[!is.na(valores)]

  if (length(valores) > 1) {
    lines(density(valores), main = paste("Mês", mes))
  }
}

legend(
  "topright",
  legend = paste("Mês", meses),
  lty = 1
)

# Resumo da variável
valores <- dados$Ozone

resumo <- data.frame(
  Medida = c("Observações", "NA", "Mínimo", "Máximo", "Média"),
  Valor = c(
    length(valores),
    sum(is.na(valores)),
    min(valores, na.rm = TRUE),
    max(valores, na.rm = TRUE),
    mean(valores, na.rm = TRUE)
  )
)

plot.new()
text(
  0,
  1,
  paste(capture.output(print(resumo)), collapse = "\n"),
  adj = c(0, 1),
  family = "mono"
)

dev.off()
