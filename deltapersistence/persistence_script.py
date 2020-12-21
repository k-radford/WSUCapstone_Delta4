#!/usr/bin/env python

# Script for computing sublevelset persistence.

import os
import argparse
import numpy as np
import matplotlib.pyplot as plot

try:
    import gudhi
except ImportError:
    print('Import failed. Check that the GUDHI library is installed.')

import deltapersistence.alkaneenergy as ae
import deltapersistence.sublevelpersistence as sp
import deltapersistence.datautils as du

parser = argparse.ArgumentParser(
    description="""Script for computing sublevelset persistence. Uses the GUDHI
        library to compute the sublevelset persistence of a given energy
        landscape. The energy landscape can be given as an energy function
        (specified by either a random sample of function values, an evenly-
        spaced mesh of function values, or a cubical complex) or an n-alkane
        molecule can be specified and the appropriate energy landscape computed
        on the fly. Minimum required arguments are an input file and filetype,
        or a molecule specification.""")
parser.add_argument('-f', '--file', type=str, default='', 
    help='Path to input file.')
parser.add_argument('-t', '--input_type', type=str, default='',
    help='Type of input file. Options are "sample", "cube", or "mesh".')
parser.add_argument('-n', '--carbons', type=int, default=0,
    help='If provided, generates the energy landscape of the alkane molecule' +
        ' with the given number of carbon atoms and uses that as input.')
parser.add_argument('-m', '--molecule', type=str, default='',
    help='If provided, generates the energy landscape of the given n-alkane ' +
        'molecule and uses that as input.')
parser.add_argument('-pd', '--periodic_dims', type=str, default=[],
    help='If a mesh is given, this lists the dimensions to treat as periodic.'+
        'This should be a string of Booleans, e.g. 101.')
parser.add_argument('-r', '--resolution', type=float, default=0.1,
    help='If generating an energy landscape, use this as the resolution.')
parser.add_argument('-c', '--field', type=int, default=11,
    help='Coefficient field for computing homology. Must be a prime.')
parser.add_argument('-of', '--output_file', type=str, default='intervals.txt',
    help='File path to write persistence intervals to.')
parser.add_argument('-d', '--dimension', type=int, default = -1,
    help='Homological dimension to return. Default is -1 (all dimensions).')
# TODO: decide if there is a better way to handle the multiple input
# function case.
parser.add_argument('-e', '--energy', type=str, default='',
    help='Path to input file containing function values for sampled data.')
parser.add_argument('--bars', action='store_true',
    help='If specified, display the barcodes.')
parser.add_argument('--diagram', action='store_true',
    help='If specified, display the persistence diagram.')
parser.add_argument('--write', action='store_true',
    help='If specified, write the persistence intervals to a file.')
parser.add_argument('--disp', action='store_true',
    help='If specified, print the persistence intervals to standard output.')
parser.add_argument('--nonbonded', action='store_true',
    help='If generating an energy landscape, use this flag to specify that ' +
        'the formula accounting for non-bonded interactions should be used. ' +
        'This is only valid butane or pentane currently.')

args = parser.parse_args()

# Format and validate input
input_type = args.input_type.lower()

print('######################################################################')

# Default to processing a file if one is specified, regardless of other
# arguments.
if args.file != '':
    if not os.path.isfile(args.file):
        print('The input file ' + args.file + ' was not found.')
        exit()
    title = 'Sublevelset Persistence for ' + args.file
    if input_type == 'sample':
        # TODO: debug.
        print('...Generating Delaunay triangulation from file ' + args.file)
        # TODO: add some try/excepts here.
        coords = np.loadtxt(args.file)
        energy = np.loadtxt(args.energy)
        lower_star_cplx = sp.lower_star_delaunay(coords,energy)
        print('...The resulting complex contains ' +
            str(lower_star_cplx.num_simplices()) + ' simplices.')
        print('...Computing persistent homology.')
        intervals = lower_star_cplx.persistence(
            homology_coeff_field=args.field)
        print('...Persistence computation complete.')
    elif input_type == 'cube':
        print('...Generating cubical complex from file ' + args.file)
        cubical_cplx = gudhi.PeriodicCubicalComplex(perseus_file=args.file)
        print('...The resulting complex contains ' +
            str(cubical_cplx.num_simplices()) + ' cubes.')
        print('...Computing persistent homology.')
        intervals = cubical_cplx.persistence(
            homology_coeff_field=args.field, min_persistence=0)
        print('...Persistence computation complete.')
    else:   # The other parameter option is 'mesh', which will be treated as
            # the default case.
        print('...Reading energy landscape from file ' + args.file)
        # Energy landscapes / function meshes should be saved as numpy .npy
        # files (the easiest format for saving ndarrays).
        try:
            fnx = np.load(args.file)
        except ValueError:
            print('The file found at ' + args.file + ' is not a valid ' +
                'Numpy array stored in .npy format.')
            exit()
        except FileNotFoundError:
            print('The file ' + args.file + ' could not be found.')
            exit()
        if fnx.ndim != len(args.periodic_dims):
            print('...Supplied periodic dimensions not valid. Proceeding ' +
                'assuming no dimensions are periodic.')
            periodic_dims = [False]*fnx.ndim
        else:
            periodic_dims = []
            for s in args.periodic_dims:
                if s == '0' or s == 'f':
                    periodic_dims.append(False)
                else:
                    periodic_dims.append(True)
        print('...Generating complex and computing persistent homology.')
        intervals = sp.mesh_sublevel_persistence(
            fnx,
            periodic_dims,
            args.field)
        print('...Persistence computation complete.')
elif args.carbons > 0 or args.molecule != '':
    if args.carbons > 3:
        molecule = ae.carbons_to_alkane(args.carbons)
        carbons = args.carbons
    elif args.molecule != '':
        molecule = args.molecule
        carbons = ae.alkane_to_carbons(args.molecule)
    else:
        print('Cannot compute the energy landscape of the n-alkane ' +
            'molecule with ' + str(args.carbons) + ' carbon atoms. ' +
            'The number of carbon atoms must be between 4 and 120.')
        exit()
    n = carbons - 3
    # Dimension of the energy landscape = number of carbons - 3.
    title = 'Sublevelset Persistence for ' + molecule.capitalize()
    print('...Computing the sublevelset persistence of ' + molecule + '.')
    if args.nonbonded:
        nb = 'taking'
    else:
        nb = 'not taking'
    print('...Determining the energy landscape of ' + molecule + ' to ' +
        'a resolution of ' + str(args.resolution) + ' and ' + nb + ' into ' +
        'account interactions between non-bonded carbons.')
    fnx_elements = int((2*np.pi/args.resolution)**n)
    print('...The function mesh has approximately ' + str(fnx_elements) +
        ' elements in it. If this is larger than 10^6 the ' +
        'computation may take a long time.')
    energy_landscape = ae.n_alkane_energy_mesh(
        n,
        args.resolution,
        args.nonbonded)
    periodic_dims = [True]*carbons
    print('...Computing persistent homology.')
    intervals = sp.mesh_sublevel_persistence(
        energy_landscape,
        periodic_dims,
        args.field)
else:
    print('No valid input parameters provided. Run this script with the ' +
        'flag "--help" to see available input options.')
    exit()
if args.dimension >= 0:
    intervals = du.intervals_in_dimension(intervals,args.dimension)
if args.disp:
    print('Persistence intervals:')
    for i in intervals:
        print(i)
if args.bars:
    print('...Generating barcodes.')
    clean_intervals = du.remove_inf_bars(intervals)
    barcode_plot = gudhi.plot_persistence_barcode(clean_intervals, legend=True)
    barcode_plot.set_title(title)
if args.diagram:
    print('...Generating persistence diagram.')
    clean_intervals = du.remove_inf_bars(intervals)
    diagram_plot = gudhi.plot_persistence_diagram(clean_intervals, legend=True)
    diagram_plot.set_title(title)
if args.bars or args.diagram:
    plot.show()
if args.write:
    print('Writing intervals to ' + args.output_file)
    du.write_intervals(intervals, args.output_file)
print('######################################################################')

