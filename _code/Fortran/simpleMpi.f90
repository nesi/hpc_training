program simpleMpi
    use mpi
    implicit none

    integer :: world_size, world_rank, name_len, ier 
    character(len=MPI_MAX_PROCESSOR_NAME) :: processor_name

    ! Initialize the MPI environment
    call mpi_init(ier)

    ! Get the number of processes
    call mpi_comm_size(MPI_COMM_WORLD, world_size, ier)

    ! Get the rank of the process
    call mpi_comm_rank(MPI_COMM_WORLD, world_rank, ier)

    ! Get the name of the processor
    call mpi_get_processor_name(processor_name, name_len, ier)

    ! Print off a hello world message
    print*, 'Hello world from processor ', processor_name, &
  &         ', rank ', world_rank, ' out of ', world_size, &
  &         ' processors'  

    ! Finalize the MPI environment
    call mpi_finalize(ier)

end program

