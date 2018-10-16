
cvec <- RColorBrewer::brewer.pal(12, 'Paired')
lvec <- 1:12
wvec = seq(3, 1, -.25)

{
i = 1
plot(obj$annual, type = 'l', lwd = wvec[i], lty = lvec[i], col = cvec[i],
     bty='l', main = "NHD annual flow volume vs. NWM 1.0: Colorado Springs COMIDs", xlab = 'COMID Index', ylab = 'Flow (cfs)')
i = i + 1
lines(obj$q0001a / 5, type = 'l', lwd = wvec[i], lty = lvec[i], col = cvec[i])

## q0001a is fow from runoff in cfs
}

{
i = 1
plot(obj$summer, type = 'l', lwd = wvec[i], lty = lvec[i], col = cvec[i], bty='l',
     main = "NWM 1.0 Seasonal Flow Volumes: Colorado Springs COMIDs", xlab = 'COMID Index', ylab = 'Flow (cfs)')
i = i + 1
lines(obj$winter, type = 'l', lwd = wvec[i], lty = lvec[i], col = cvec[i])
i = i + 1
lines(obj$fall, type = 'l', lwd = wvec[i], lty = lvec[i], col = cvec[i])
i = i + 1
lines(obj$spring, type = 'l', lwd = wvec[i], lty = lvec[i], col = cvec[i])
}

{
i = 1
plot(obj$Sep, type = 'l', lwd = wvec[i], lty = lvec[i], col = cvec[i], bty='l',
     main = "NWM 1.0 Monthly Flow Volumes: Colorado Springs COMIDs", xlab = 'COMID Index', ylab = 'Flow (cfs)')
i = i + 1
lines(obj$Oct, type = 'l', lwd = wvec[i], lty = lvec[i], col = cvec[i])
i = i + 1
lines(obj$Nov, type = 'l', lwd = wvec[i], lty = lvec[i], col = cvec[i])
i = i + 1
lines(obj$Dec, type = 'l', lwd = wvec[i], lty = lvec[i], col = cvec[i])
i = i + 1
lines(obj$Jan, type = 'l', lwd = wvec[i], lty = lvec[i], col = cvec[i])
i = i + 1
lines(obj$Feb, type = 'l', lwd = wvec[i], lty = lvec[i], col = cvec[i])
i = i + 1
lines(obj$Mar, type = 'l', lwd = wvec[i], lty = lvec[i], col = cvec[i])
i = i + 1
lines(obj$Apr, type = 'l', lwd = wvec[i], lty = lvec[i], col = cvec[i])
i = i + 1
lines(obj$May, type = 'l', lwd = wvec[i], lty = lvec[i], col = cvec[i])
i = i + 1
lines(obj$Jun, type = 'l', lwd = wvec[i], lty = lvec[i], col = cvec[i])
i = i + 1
lines(obj$Jul, type = 'l', lwd = wvec[i], lty = lvec[i], col = cvec[i])
i = i + 1
lines(obj$Aug, type = 'l', lwd = wvec[i], lty = lvec[i], col = cvec[i])
}





