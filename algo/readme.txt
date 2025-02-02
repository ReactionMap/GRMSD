Three algorithms are provided for G-RMSD:
   ICP.m : AO (Alternate Optimization) method
   matching8.m : TSR (Target Space Relaxation) method
   three_points.m : 3P (Three-points) method

Input: A, B, label_A, label_B, permit_mirror
Output: RMSD values

for any of the algorithms.

*The 3P method is only for more than three-atoms both in the query and target.

A, B : matrix of the cartesian coordinates of atoms. If the number of the atoms (NA for A, NB for B) are different, it should be NA < NB.

label_A, label_B: Arrays containing the atom types of A and B, respectively. If this information is not used, set zero.

permit_mirror : Permit chirality (true) or not (false) in the RMSD calculation. Default is false.

------------------------------------------------------------


@ Tips:

The calculation times and the output are almost the same between the AO and 3P methods when comparing molecules composing the same number of atoms.

The 3P method would be better to compare molecules of different sizes.
