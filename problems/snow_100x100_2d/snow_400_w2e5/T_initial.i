[Mesh]
  type = FileMesh
  file = phi_initial_0001_mesh.xdr
  dim = 2
[]

[Variables]
  [./T]
    initial_condition = 268
  [../]
[]

[AuxVariables]
  [./u]
  [../]
  [./phi]
  [../]
[]

[Kernels]
  [./heat_diffusion]
    type = PikaDiffusion
    variable = T
    use_temporal_scaling = true
    property = conductivity
  [../]
[]

[AuxKernels]
  [./phi_aux_kernel]
    type = SolutionAux
    variable = phi
    execute_on = initial
    solution = phi_initial
  [../]
[]

[BCs]
  [./T_hot]
    type = DirichletBC
    variable = T
    boundary = top
    value = 270
  [../]
  [./T_cold]
    type = DirichletBC
    variable = T
    boundary = bottom
    value = 268
  [../]
[]

[UserObjects]
  [./phi_initial]
    type = SolutionUserObject
    system = aux0
    mesh = phi_initial_0001_mesh.xdr
    nodal_variables = phi_aux
    es = phi_initial_0001.xdr
    system_variables = phi_aux
  [../]
[]

[Executioner]
  # Preconditioned JFNK (default)
  type = Steady
  solve_type = PJFNK
  petsc_options_iname = '-ksp_gmres_restart -pc_type -pc_hypre_type'
  petsc_options_value = '500 hypre boomeramg'
[]

[Outputs]
  exodus = true
  console = false
  [./console]
    type = Console
    perf_log = true
    nonlinear_residuals = true
    linear_residuals = true
  [../]
  [./xdr]
    file_base = T_initial
    output_final = true
    type = XDR
  [../]
[]

[PikaMaterials]
  temperature = 263.15
  interface_thickness = 5e-6
  phase = phi
[]
