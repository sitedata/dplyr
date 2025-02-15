% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/transmute.R
\name{transmute}
\alias{transmute}
\title{Create, modify, and delete columns}
\usage{
transmute(.data, ...)
}
\arguments{
\item{.data}{A data frame, data frame extension (e.g. a tibble), or a
lazy data frame (e.g. from dbplyr or dtplyr). See \emph{Methods}, below, for
more details.}

\item{...}{<\code{\link[=dplyr_data_masking]{data-masking}}> Name-value pairs.
The name gives the name of the column in the output.

The value can be:
\itemize{
\item A vector of length 1, which will be recycled to the correct length.
\item A vector the same length as the current group (or the whole data frame
if ungrouped).
\item \code{NULL}, to remove the column.
\item A data frame or tibble, to create multiple columns in the output.
}}
}
\value{
An object of the same type as \code{.data}. The output has the following
properties:
\itemize{
\item Columns created or modified through \code{...} will be returned in the order
specified by \code{...}.
\item Unmodified grouping columns will be placed at the front.
\item The number of rows is not affected.
\item Columns given the value \code{NULL} will be removed.
\item Groups will be recomputed if a grouping variable is mutated.
\item Data frame attributes are preserved.
}
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#superseded}{\figure{lifecycle-superseded.svg}{options: alt='[Superseded]'}}}{\strong{[Superseded]}}

\code{transmute()} creates a new data frame containing only the specified
computations. It's superseded because you can perform the same job
with \code{mutate(.keep = "none")}.
}
\section{Methods}{

This function is a \strong{generic}, which means that packages can provide
implementations (methods) for other classes. See the documentation of
individual methods for extra arguments and differences in behaviour.

Methods available in currently loaded packages:
\Sexpr[stage=render,results=rd]{dplyr:::methods_rd("transmute")}.
}

\keyword{internal}
