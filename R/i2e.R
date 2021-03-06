#' Importing to Export
#' 
#' @name i2e
#' @param x A Leontief decomposed Inter-Country Input Output table as created by decompr
#' @export
#' @import decompr

i2e <- function( x ) {
  
  # read attributes
  k      <- attr(x, "k")
  i      <- attr(x, "i")
  # rownam <- attr(x, "rownam")
  G <- length(k)
  N <- length(i)
  
  # transform back to 2dim x 2dim matrix
  x <- matrix(x[,5], nrow=G*N, byrow=TRUE)
  
  # remove exports to self
  f <- colSums (minus_block_matrix( x, N ) )

  # divide by own exports
  for (j in 1:N) {
    s <- seq( ((j-1)*N + 1), j*N )
    f[s] <- f[s] / sum(colSums(x[,s]))
  }
  
  f <- as.data.frame(f)
  f <- cbind(rep(k, each = N),
             rep(i, times = G),
             f)
  rownames(f) <- NULL  
  names(f) <- c("country", "sector", "i2e")
  
  return(f)
  
}

# alias

#' Vertical Specialization
#' @rdname i2e

vertical_specialisation <- i2e

# Americano alias

#' Vertical Specialisation
#' @rdname i2e
vertical_specialization <- i2e