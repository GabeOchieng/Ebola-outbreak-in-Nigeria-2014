# System Dynamics: Ebola outbreak 2014 in Nigeria

Differential equations are an invaluable tool for modelling and analysis of complex systems. 
In System Dynamics terminology they model stocks and flows. 
Unfortunately, their handling is not trivial and outside academia it is not very common to make use of it. 
However, with just a few lines of code it is possible to plot the functions which allows a straightforward interpretation of the interdependencies.
To make this work, the initial conditions and the coefficients of the equations must be known.


<a href="http://dx.doi.org/10.1016/j.epidem.2015.03.001">Althaus et al. (2015)</a> estimated coefficients for the following set of differential equations modelling the Ebola outbreak 2014 in Nigeria.

\begin{align}
\frac{\partial S}{\partial t} & = -\beta(t) S I \\
\frac{\partial E}{\partial t} & = \beta(t) S I - \sigma E \\
\frac{\partial I}{\partial t} & = \sigma E - \gamma I \\
\frac{\partial R}{\partial t} & = (1-f) \gamma I \\
\frac{\partial D}{\partial t} & = f \gamma I \\
\end{align}

$S$ = susceptible, $E$ = exposed, $I$ = infectious, $R$ = recovered, $D$ = dead

<img src="https://ars.els-cdn.com/content/image/1-s2.0-S1755436515000341-gr1.jpg" />

These are the coefficients:

\begin{align}
\beta(t) & = \beta_{0} e^{-k(t - \tau)} \\
\beta_0 & = 1.22 * 10^{-6} \\
\sigma & = 0.11 \\
\gamma & = 0.13 \\
f & = 0.39 \\
\tau & = 3 \\
k & = 0.19
\end{align}

$\beta$: transmission rate with infected individuals, 
$\gamma$: ‘‘recovery or death’’ rate, 
$\sigma$: incubation rate, 
$f$: case fatality rate, 
$\tau$: Time (in days) at which control measures were introduced, 
k: transmission reduction rate

All initial stocks at t=0 are empty except S(0) = $10^{6}$ and I(0) = 1. 
The development is computed over 100 days. 
Perhaps surprising is that the recovered become immune to Ebola.

The transmission rate ($\beta$) is expected to be constant until the implementation of control interventions at t=$\tau$ and exponentionally decaying afterwards. 
The comparison of the proposed model with one having a constant transmission rate points out the tremendous importance of rapid implementation of control measures in order to reduce the spread of the disease.

Reference: <br />
Althaus C.L., Low N, Musa E.O., Shuaib F., Gsteiger S. (2015). <a href="http://dx.doi.org/10.1016/j.epidem.2015.03.001">Ebola virus disease outbreak in Nigeria: transmission dynamics and rapid control</a>. Epidemics 11(0): 80–84
