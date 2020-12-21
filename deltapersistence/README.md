# deltapersistence

Package implementing the persistent homology code from the NSF-DELTA project.


## Outline

This python package will contain at least two modules:
* Alkane Energy - provides methods for computing the energy landscapes of the alkane series, using the formulae provided by YZ's group.
* Sublevel Persistence - provides general methods for computing sublevel set persistent homology (using GUDHI).
* A possible third module could contain methods for analysis, e.g. Wasserstein distances.
Several example scripts should also be included.

We have two goals:
* Make replication of our computations as simple as installation of this package and running an example script.
* Provide useful methods for conducting future experiments.


## Project Development

The alkane energy module mostly exists as MATLAB code already, and I have begun converting that to python. A couple methods still need to be converted (specifically, those for writing output files).

The sublevel persistence module is not yet implemented. Basic computations can be run by calling GUDHI's methods on the alkane output files. Major tasks here are:
* Implement sublevel filtration on arbitrary complexes.
* Compute Delauney complexes for datasets, with correct energy filtration

In addition, several example scripts should be written once the above features are implemented, and the code should be documented and tested thoroughly.

Detailed descriptions shall be added as issues in Gitlab.


## Contribution

We will use the "feature branch" workflow for git; see the useful links below.

Details of the development issues listed above will be added as issues in the Gitlab repository.

Periodically (when the code is "complete" up to some set of features) we will copy this to the main DELTA repository, but all development should happen here.


## Useful Links

* About documenting python code: https://realpython.com/documenting-python-code/
* Numpy-style docstrings: https://numpydoc.readthedocs.io/en/latest/format.html
* Python modules: https://www.tutorialspoint.com/python/python_modules.htm
* Structure of a python package: https://packaging.python.org/tutorials/packaging-projects/
* Tutorial on the git "feature branch" workflow: https://www.atlassian.com/git/tutorials/comparing-workflows/feature-branch-workflow
* Tutorial on general git collaboration: https://www.atlassian.com/git/tutorials/syncing
* Style guide for python: https://www.python.org/dev/peps/pep-0008/#function-and-variable-names

## Getting started

* Download and install GUDHI.
* Clone this repository.
* Navigate into the folder `deltapersistence/deltapersistence/`.
* At the command prompt, run `python3 persistence_script.py --carbons 5 --disp`.
  This should produce the barcodes for pentane.
* Run `python3 persistence_script.py -f ../tests/cube.txt -t cube --bars`.
  This should generate the bars for pentane with non-bonded interactions which
  are saved as a cubical complex in the data file `cube.txt`.
* Run `python3 persistence_script.py -f ../tests/mesh.npy -t mesh --diagram`.
  This should generate the persistence diagram for hexane from the
  energy landscape saved as `mesh.npy`. It will take a few moments.
* Run `python3 persistence_script.py --help` to see all available
  options, then experiment with some of them!
  

