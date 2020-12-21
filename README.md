Delta4 Team Repo created for Final Report

Members: Kate Radford, Travis Cripe, Marco Ares and Joshua Stallworth

DELTA NSF Gateway: delta-topology.org

(Copies of) Applications hosted on the gateway:

[ChemNetworks](https://gitlab.com/ChemNetworks-Dev/ChemNetworks-2-2)

[DeltaPersistence](https://gitlab.com/thrust-2/thrust2/-/tree/master/software/deltapersistence)

[AnalyzeTrajectory](https://gitlab.com/Example-landscapes/energy-landscape_nucleophilic-attack)

The rest are not on public repos

Goal: Implement CI/CD for applications with *pre-existing* test methods

Results: Due to the need for test methods in order to implement CI/CD for an application, this very much limited
the number of applications we could apply our final solution to. However, this solution can be easily modified for
the rest once tests are made for them (gateway is in the early stages of development).

Files uploaded:
ChemNetworks-2-2-master: Holds finalized test script (test.sh) and yaml file (.travis.yml) for TravisCI
ChemNet: Kate's working directory off stampede2. Holds all shell scripts written from very first to final solution.
         testChemNet.slurm was tweaked for test.sh and chemNet.slurm is final workflow script for the gateway application.
DeltaPersistence: Holds test script (testDeltaPersistence.sh) and yaml file (travis.yml) for TravisCI
