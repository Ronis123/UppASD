# Turns on either OpenMP or MPI
# If both are requested, the other is disabled
# When one is turned on, the other is turned off
# If both are off, we explicitly disable them just in case

IF (USE_OPENMP)
    # Find OpenMP
    IF (NOT OpenMP_Fortran_FLAGS)
        FIND_PACKAGE (OpenMP_Fortran)
        IF (NOT OpenMP_Fortran_FLAGS)
            MESSAGE (FATAL_ERROR "Fortran compiler does not support OpenMP")
        ENDIF (NOT OpenMP_Fortran_FLAGS)
    ENDIF (NOT OpenMP_Fortran_FLAGS)
    # Turn of MPI
    UNSET (MPI_FOUND CACHE)
    UNSET (MPI_COMPILER CACHE)
    UNSET (MPI_LIBRARY CACHE)
ELSE ()
    # Turn off both OpenMP and MPI
    SET (OMP_NUM_PROCS 0 CACHE
         STRING "Number of processors OpenMP may use" FORCE)
    UNSET (OpenMP_Fortran_FLAGS CACHE)
    UNSET (GOMP_Fortran_LINK_FLAGS CACHE)
    UNSET (MPI_FOUND CACHE)
    UNSET (MPI_COMPILER CACHE)
    UNSET (MPI_LIBRARY CACHE)
ENDIF (USE_OPENMP)
