# numpy
import numpy as np
from numpy import log, log10, sin, cos, exp, sqrt, pi, heaviside
from numpy.random import default_rng
rng = default_rng()
np.random.seed(42)

# scipy
from scipy.integrate import quad
from scipy.special import kv, erf
from scipy.constants import pi, c, alpha, hbar, e
from scipy.optimize import fsolve

# matplotlib
import matplotlib.pyplot as plt

# tqdm
from tqdm.notebook import tqdm
from tqdm import trange

def arraycenter(x):
    """
        returns centered array
    """
    return np.array([(x[i]+x[i+1])/2 for i in range(len(x)-1)])

def d2Pdeta(chi,eta):
    """
    nBW as in eq 3.11 of PhD Thesis of Marija Vranic
    chitil - chi tilde
    chip - chi plus
    chim - chi minus
    """
    chip = eta/chi;
    chim = 1 - chip;
    chitil = 2/(3*chi*chip*chim);
    return 1/chi * ( (chip/chim + chim/chip) * kv(2/3,chitil) + quad(lambda x: kv(1/3,x), chitil, np.inf)[0] );
d2Pdeta = np.vectorize(d2Pdeta)

def pair_aux(chi,ndraws):
    """
    nBW Sample from nBW and return sample and efficiency of Rejection Method
    """
    epsmaq = 1e-3;
    counts = 0; # total number of draws
    etalst = chi*np.linspace(epsmaq,1-epsmaq);
    
    def fun(eta): return d2Pdeta(chi,eta); # function to sample from
    fun = np.vectorize(fun)
    dP1 = fun(etalst);
    multc = 1.01*np.max(dP1); # the c in c q(x)
    
    xmin = epsmaq; xmax = chi-epsmaq; # define interval to sample from
    xlst = np.zeros(ndraws); # array of samples
    
    # sample
    i=0;
    while i < ndraws:
        y = (xmax-xmin)*rng.random()+xmin; # take Y from uniform distribution [xmin,xmax]
        u = rng.random(); # take U from uniform distribution [0,1]
        if multc*u <= fun(y): # accept value only if U < c Y
            xlst[i] = y;
            i = i + 1;
        counts = counts+1;
        
    return xlst, ndraws/counts

def d2Pdchi(eta,chi):
    """
    nCS as in eq 3.9 of PhD Thesis of Marija Vranic
    chitil - chi tilde
    chip - chi plus
    chim - chi minus
    """
    csi = chi/eta;
    chitil = 2*csi/(3*eta*(1-csi));
    return 1/eta * ( (1-csi+1/(1-csi)) * kv(2/3,chitil) - quad(lambda x: kv(1/3,x), chitil, np.inf)[0] );
d2Pdchi = np.vectorize(d2Pdchi)

def photon_aux(eta,ndraws):
    """
    nCS Sample from nCS and return sample and efficiency of Rejection Method
    """
    epsmaq = 1e-3;
    counts = 0; # total number of draws
    chilst = eta*np.linspace(epsmaq,1-epsmaq);
    
    def fun(chi): return chi*d2Pdchi(eta,chi); # function to sample from
    fun = np.vectorize(fun)
    dP1 = fun(chilst);
    multc = 1.01*np.max(dP1); # the c in c q(x)
    
    xmin = epsmaq; xmax = eta-epsmaq; # define interval to sample from
    xlst = np.zeros(ndraws); # array of samples
    
    # sample
    i=0;
    while i < ndraws:
        y = (xmax-xmin)*rng.random()+xmin; # take Y from uniform distribution [xmin,xmax]
        u = rng.random(); # take U from uniform distribution [0,1]
        if multc*u <= fun(y): # accept value only if U < c Y
            xlst[i] = y;
            i = i + 1;
        counts = counts+1;
        
    return xlst, ndraws/counts
