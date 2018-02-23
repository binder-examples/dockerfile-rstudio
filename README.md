# RStudio in Binder using a Dockerfile

[![Binder](http://mybinder.org/badge.svg)](http://mybinder.org/v2/gh/binder-examples/dockerfile-rstudio/master)

***NOTE**: RStudio/R support is now supported natively in Binder. See the
[R example repository](https://github.com/binder-examples/r) for how to
create an RStudio session using `runtime.txt`.*

This is a proof-of-concept to deploy a Binder that exposes the
RStudio UI instead of a Jupyter Notebook. It also installs
several packages from the tidyverse, and includes a demo
script to show off functionality.

To start your RStudio session, click on "new" in the top right,
and at the bottom will be `RStudio Session`.
Click that and your RStudio session will begin momentarily!

See `instructions.ipynb` for more details.

*Special thanks to Ryan Lovett (@ryanlovett) for figuring out
RStudio support with JupyterHub*
