Visualisierung_Zitate
quotes.v <- scan("quotes.txt", what="character", sep="\n") # Die Datei „quotes.txt“ beinhaltet nur die Seitenzahlen der einzelnen Werke. Die Seitenzahlen jedes Werkes befinden sich auf einer Zeile und sind mit einem Leerzeichen voneinander getrennt. 
quotes.v <- quotes.v[1] # Die Nummern in [] bezeichnen das aktuelle Werk
quotes.l <- strsplit(quotes.v, "\\s")
pages.v <- seq(1:1004) # Anzahl der von Millinger paginierten Seiten
quotes.v <- unlist(quotes.l)
quotes.v <- as.numeric(quotes.v)
w.count.v <- rep(NA,length(pages.v))
w.count.v[quotes.v] <- 1
w.count.v
plot(w.count.v, main="TITEL DES BUCHES", 
   xlab=legend.v, ylab=length(quotes.v), type="h", ylim=c(0,0.1), yaxt='n')
