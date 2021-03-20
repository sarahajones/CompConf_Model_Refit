classdef (Sealed) Fminunc < optim.options.MultiAlgorithm
%

%Fminunc Options for FMINUNC
%
%   The OPTIM.OPTIONS.FMINUNC class allows the user to create a set of
%   options for the FMINUNC solver. For a list of options that can be set,
%   see the documentation for FMINUNC.
%
%   OPTS = OPTIM.OPTIONS.FMINUNC creates a set of options for FMINUNC
%   with the options set to their default values.
%
%   OPTS = OPTIM.OPTIONS.FMINUNC(PARAM, VAL, ...) creates a set of options
%   for FMINUNC with the named parameters altered with the specified
%   values.
%
%   OPTS = OPTIM.OPTIONS.FMINUNC(OLDOPTS, PARAM, VAL, ...) creates a copy
%   of OLDOPTS with the named parameters altered with the specified values.
%
%   See also OPTIM.OPTIONS.MULTIALGORITHM, OPTIM.OPTIONS.SOLVEROPTIONS    

%   Copyright 2012-2017 The MathWorks, Inc.

    properties (Dependent)

%CHECKGRADIENTS Compare user-supplied gradients to finite-differencing
%               derivatives
%
%   For more information, type "doc fminunc" and see the "Options" section
%   in the FMINUNC documentation page.
        CheckGradients

%DISPLAY Level of display
%
%   For more information, type "doc fminunc" and see the "Options" section
%   in the FMINUNC documentation page.        
        Display
        
%FINITEDIFFERENCESTEPSIZE Scalar or vector step size factor
%
%   For more information, type "doc fminunc" and see the "Options" section
%   in the FMINUNC documentation page.
        FiniteDifferenceStepSize
        
%FINITEDIFFERENCETYPE Finite difference type
%
%   For more information, type "doc fminunc" and see the "Options" section
%   in the FMINUNC documentation page.
        FiniteDifferenceType

%FUNCTIONTOLERANCE Termination tolerance on the change in function value
%
%   For more information, type "doc fminunc" and see the "Options" section
%   in the FMINUNC documentation page.
        FunctionTolerance        
        
%HESSIANFCN Function handle to a function that computes the Hessian
%
%   For more information, type "doc fminunc" and see the "Options" section
%   in the FMINUNC documentation page.
        HessianFcn        

%HESSIANMULTIPLYFCN Function handle for Hessian multiply function
%
%   For more information, type "doc fminunc" and see the "Options" section
%   in the FMINUNC documentation page.
        HessianMultiplyFcn

%MAXFUNCTIONEVALUATIONS Maximum number of function evaluations allowed
%
%   For more information, type "doc fminunc" and see the "Options" section
%   in the FMINUNC documentation page.
        MaxFunctionEvaluations
        
%MAXITERATIONS Maximum number of iterations allowed
%
%   For more information, type "doc fminunc" and see the "Options" section
%   in the FMINUNC documentation page.
        MaxIterations
        
%OBJECTIVELIMIT Lower limit on the objective function
% 
%   For more information, type "doc fminunc" and see the "Options" section
%   in the FMINUNC documentation page.       
        ObjectiveLimit        

%OPTIMALITYTOLERANCE Termination tolerance on the first-order optimality
%                    measure
%
%   For more information, type "doc fminunc" and see the "Options" section
%   in the FMINUNC documentation page.
        OptimalityTolerance               
        
%OUTPUTFCN Callbacks that are called at each iteration
% 
%   For more information, type "doc fminunc" and see the "Options" section
%   in the FMINUNC documentation page.        
        OutputFcn
        
%PLOTFCN Plots various measures of progress while the algorithm executes
% 
%   For more information, type "doc fminunc" and see the "Options" section
%   in the FMINUNC documentation page.        
        PlotFcn
 
%SPECIFYOBJECTIVEGRADIENT Gradient for the objective function
%                         defined by the caller
%
%   For more information, type "doc fminunc" and see the "Options" section
%   in the FMINUNC documentation page.
        SpecifyObjectiveGradient
        
%STEPTOLERANCE Termination tolerance on the displacement in x
%
%   For more information, type "doc fminunc" and see the "Options" section
%   in the FMINUNC documentation page.
        StepTolerance        

%SUBPROBLEMALGORITHM Determines how the iteration step is calculated
%
%   For more information, type "doc fminunc" and see the "Options" section
%   in the FMINUNC documentation page.
        SubproblemAlgorithm

%TYPICALX Typical x values        
% 
%   For more information, type "doc fminunc" and see the "Options" section
%   in the FMINUNC documentation page.        
        TypicalX
        
    end


% Old Hidden properties
    properties (Hidden, Dependent)
 
%DERIVATIVECHECK Compare user-supplied derivatives to finite-differencing 
%                derivatives
        DerivativeCheck
        
%DIAGNOSTICS Display diagnostic information 
        Diagnostics
        
%DIFFMAXCHANGE Maximum change in variables for finite-difference gradients        
        DiffMaxChange
        
%DIFFMINCHANGE Minimum change in variables for finite-difference gradients        
        DiffMinChange
               
%FINDIFFRELSTEP Scalar or vector step size factor
        FinDiffRelStep
        
%FINDIFFTYPE Finite difference type
        FinDiffType
        
%FUNVALCHECK Check whether objective function and constraints values are
%            valid
        FunValCheck
        
%GRADOBJ Gradient for the objective function defined by the user
        GradObj
        
%HESSIAN Specify whether a user-supplied Hessian will be supplied
        Hessian
        
%HESSMULT Function handle for Hessian multiply function        
        HessMult
        
%HESSPATTERN Sparsity pattern of the Hessian for finite differencing
        HessPattern
        
%HESSUPDATE Method for choosing the search direction in the Quasi-Newton algorithm        
        HessUpdate
                
%MAXFUNEVALS Maximum number of function evaluations allowed   
        MaxFunEvals
        
%MAXITER Maximum number of iterations allowed 
        MaxIter
        
%MAXPCGITER Maximum number of PCG (preconditioned conjugate gradient) 
%           iterations        
        MaxPCGIter
        
%PLOTFCNS Plots various measures of progress while the algorithm executes
        PlotFcns
        
%PRECONDBANDWIDTH Upper bandwidth of preconditioner for PCG
        PrecondBandWidth
        
%TOLFUN Termination tolerance on the function value
        TolFun
        
%TOLPCG Termination tolerance on the PCG iteration
        TolPCG
        
%TOLX Termination tolerance on x
        TolX
        
%USEPARALLEL Option to compute finite-difference gradients in parallel        
% 
%   For more information, type "doc fminunc" and see the "UseParallel" section
%   in the FMINUNC documentation page.
        UseParallel 
        
    end
    
    properties (Hidden, Access = protected)
%OPTIONSSTORE Contains the option values and meta-data for the class
%          
        OptionsStore = createOptionsStore;
    end

    properties (Hidden)
%SOLVERNAME Name of the solver that the options are intended for
%         
        SolverName = 'fminunc';
    end       

    properties (Hidden, SetAccess = private, GetAccess = public)
        
        % New version property added in second version
        FminuncVersion
    end
    
     properties(Hidden, Constant, GetAccess=public)
% Constant, globally visible metadata about this class.
% This data is used to spec the options in this class for internal clients
% such as: tab-complete, and the options validation
% Properties
        PropertyMetaInfo = genPropInfo();    
    end
    
   methods (Hidden)
       
       
        
        function obj = Fminunc(varargin)
%Fminunc Options for FMINUNC
%
%   The OPTIM.OPTIONS.FMINUNC class allows the user to create a set of
%   options for the FMINUNC solver. For a list of options that can be set,
%   see the documentation for FMINUNC.
%
%   OPTS = OPTIM.OPTIONS.FMINUNC creates a set of options for FMINUNC
%   with the options set to their default values.
%
%   OPTS = OPTIM.OPTIONS.FMINUNC(PARAM, VAL, ...) creates a set of options
%   for FMINUNC with the named parameters altered with the specified
%   values.
%
%   OPTS = OPTIM.OPTIONS.FMINUNC(OLDOPTS, PARAM, VAL, ...) creates a copy
%   of OLDOPTS with the named parameters altered with the specified values.
%
%   See also OPTIM.OPTIONS.MULTIALGORITHM, OPTIM.OPTIONS.SOLVEROPTIONS    
            
            % Call the superclass constructor
            obj = obj@optim.options.MultiAlgorithm(varargin{:});
               
            % Record the class version; Update property 'FminuncVersion'
            % instead of superclass property 'Version'.
            obj.Version = 1;
            obj.FminuncVersion = 5;        
        end
        
        function optionFeedback = createOptionFeedback(obj)
%createOptionFeedback Create option feedback string 
%
%   optionFeedback = createOptionFeedback(obj) creates an option feedback
%   strings that are required by the extended exit messages. OPTIONFEEDBACK
%   is a structure containing strings for the options that appear in the
%   extended exit messages. These strings indicate whether the option is at
%   its 'default' value or has been 'selected'. 
           
            % It is possible for a user to pass in a vector of options to
            % the solver. Silently use the first element in this array.
            obj = obj(1);
            
            % Check if TolFunValue is the default value
            if obj.OptionsStore.SetByUser.TolFunValue
                optionFeedback.TolFunValue = 'selected';
            else
                optionFeedback.TolFunValue = 'default';
            end
            
            % Check if TolFun is the default value
            if obj.OptionsStore.SetByUser.TolFun
                optionFeedback.TolFun = 'selected';
            else
                optionFeedback.TolFun = 'default';
            end
            
            % Check if TolX is the default value
            if obj.OptionsStore.SetByUser.TolX
                optionFeedback.TolX = 'selected';
            else
                optionFeedback.TolX = 'default';
            end
            
            % Check if MaxIter is the default value
            if obj.OptionsStore.SetByUser.MaxIter
                optionFeedback.MaxIter = 'selected';
            else
                optionFeedback.MaxIter = 'default';
            end
            
            % Check if MaxFunEvals is the default value
            if obj.OptionsStore.SetByUser.MaxFunEvals
                optionFeedback.MaxFunEvals = 'selected';
            else
                optionFeedback.MaxFunEvals = 'default';
            end
            
            % Check if ObjectiveLimit is the default value
            if obj.OptionsStore.SetByUser.ObjectiveLimit
                optionFeedback.ObjectiveLimit = 'selected';
            else
                optionFeedback.ObjectiveLimit = 'default';
            end
        end
        
        function obj = replaceSpecialStrings(obj)
            %replaceSpecialStrings Replace special string values 
            %
            %   obj = replaceSpecialStrings(obj) replaces special string
            %   option values with their equivalent numerical value. We
            %   currently only use this method to convert FinDiffRelStep.
            %   However, in the future we would like to move the special
            %   string replacement code from the solver files to the
            %   options classes.
           
            % Call a package function to replace string values in
            % FinDiffRelStep.
            obj.OptionsStore.Options.FinDiffRelStep = ...
                optim.options.replaceFinDiffRelStepString(obj.FinDiffRelStep);
        end        
        
    end
    
    % Set/get methods
    methods
        
        function obj = set.UseParallel(obj,value)
            obj = setProperty(obj,'UseParallel',value);
        end
        
        % ---------------------- Set methods ------------------------------
        
        function obj = set.CheckGradients(obj, value)
            obj = setNewProperty(obj, 'CheckGradients', value);
        end                
        
        function obj = set.DerivativeCheck(obj, value)
            obj = setProperty(obj, 'DerivativeCheck', value);
        end
        
        function obj = set.Diagnostics(obj, value)
            obj = setProperty(obj, 'Diagnostics', value);
        end
        
        function obj = set.DiffMinChange(obj, value)
            obj = setProperty(obj, 'DiffMinChange', value);
        end
        
        function obj = set.DiffMaxChange(obj, value)
            obj = setProperty(obj, 'DiffMaxChange', value);
        end
        
        function obj = set.Display(obj, value)
            if strcmpi(value, 'testing')
                % Set Display to the undocumented value, 'testing'.
                obj = setPropertyNoChecks(obj, 'Display', 'testing');
            else
                % Pass the possible values that the Display option can take
                % via the fourth input of setProperty.
                obj = setProperty(obj, 'Display', value, ...
                    {'off','none','notify','notify-detailed','final', ...
                    'final-detailed','iter','iter-detailed'});
            end
        end
        
        function obj = set.FiniteDifferenceStepSize(obj, value)
            obj = setAliasProperty(obj, 'FiniteDifferenceStepSize', 'FinDiffRelStep', value);
        end                
        
        function obj = set.FinDiffRelStep(obj, value)
            obj = setProperty(obj, 'FinDiffRelStep', value);
        end
        
        function obj = set.FiniteDifferenceType(obj, value)
            obj = setAliasProperty(obj, 'FiniteDifferenceType', 'FinDiffType', value);     
            % If we get here, the property set has been successful and we
            % can update the OptionsStore
            if ~obj.OptionsStore.SetByUser.FinDiffRelStep
                obj.OptionsStore.Options.FinDiffRelStep = ...
                    optim.options.getDefaultFinDiffRelStep(...
                    obj.OptionsStore.Options.FinDiffType);
            end            
        end         
        
        function obj = set.FinDiffType(obj, value)
            obj = setProperty(obj, 'FinDiffType', value);
            % If we get here, the property set has been succesful and we
            % can update the OptionsStore
            if ~obj.OptionsStore.SetByUser.FinDiffRelStep
                obj.OptionsStore.Options.FinDiffRelStep = ...
                    optim.options.getDefaultFinDiffRelStep(...
                    obj.OptionsStore.Options.FinDiffType);
            end
        end

        function obj = set.FunctionTolerance(obj, value)
            obj = setAliasProperty(obj, 'FunctionTolerance', 'TolFunValue', value);        
        end  
                
        function obj = set.FunValCheck(obj, value)
            obj = setProperty(obj, 'FunValCheck', value);
        end        
        
        function obj = set.GradObj(obj, value)
            obj = setProperty(obj, 'GradObj', value);
        end
                
        function obj = set.Hessian(obj, value)
            obj = setProperty(obj, 'Hessian', value, ...
                {'on','off','user-supplied','fin-diff-grads'});
            
            % If HessianMultiplyFcn has not been set and Hessian has been
            % set this means that the user wants to either supply a Hessian
            % via an objective function ('on') or not supply a Hessian at
            % all ('off')
            if ~obj.OptionsStore.SetByUser.HessMult
                if strcmp(value, 'on')
                    HessianFcnValue = 'objective';
                else
                    HessianFcnValue = [];
                end
                obj = setNewProperty(obj, 'HessianFcn', HessianFcnValue);                
            end
        end

        function obj = set.HessianFcn(obj, value)
            obj = setNewProperty(obj, 'HessianFcn', value);
            % Additional screening. HessianFcn can only be set to
            % 'objective' or [] for fminunc.
            if ~isempty(value) && ~((ischar(value) || (isstring(value) && isscalar(value)))...
                    && strcmpi(value,'objective'))
                error(message('optim:options:Fminunc:InvalidHessianFcn'));
            end
        end        
        
        function obj = set.HessianMultiplyFcn(obj, value)
            obj = setNewProperty(obj, 'HessianMultiplyFcn', value);
        end
        
        function obj = set.HessMult(obj, value)
            obj = setProperty(obj, 'HessMult', value);
        end
        
        function obj = set.HessPattern(obj, value)
            obj = setProperty(obj, 'HessPattern', value);
        end
        
        function obj = set.HessUpdate(obj, value)
            obj = setProperty(obj, 'HessUpdate', value);
        end        
        
        function obj = set.MaxFunctionEvaluations(obj, value)
            obj = setAliasProperty(obj, 'MaxFunctionEvaluations', 'MaxFunEvals', value);        
        end                
        
        function obj = set.MaxFunEvals(obj, value)
            obj = setProperty(obj, 'MaxFunEvals', value);
        end
                
        function obj = set.MaxIterations(obj, value)
            obj = setAliasProperty(obj, 'MaxIterations', 'MaxIter', value);        
        end        
        
        function obj = set.MaxIter(obj, value)
            obj = setProperty(obj, 'MaxIter', value);
        end
        
        function obj = set.MaxPCGIter(obj, value)
            obj = setProperty(obj, 'MaxPCGIter', value);
        end

        function obj = set.ObjectiveLimit(obj, value)
            obj = setProperty(obj, 'ObjectiveLimit', value);
        end

        function obj = set.OptimalityTolerance(obj, value)
            obj = setAliasProperty(obj, 'OptimalityTolerance', 'TolFun', value);        
        end          
        
        function obj = set.OutputFcn(obj, value)
            obj = setProperty(obj, 'OutputFcn', value);
        end
        
        function obj = set.PlotFcn(obj, value)
            obj = setAliasProperty(obj, 'PlotFcn', 'PlotFcns', value);        
        end          
        
        function obj = set.PlotFcns(obj, value)
            obj = setProperty(obj, 'PlotFcns', value);
        end
        
        function obj = set.PrecondBandWidth(obj, value)
            obj = setProperty(obj, 'PrecondBandWidth', value);
        end

        function obj = set.SpecifyObjectiveGradient(obj, value)
            obj = setNewProperty(obj, 'SpecifyObjectiveGradient', value);
        end        
                
        function obj = set.StepTolerance(obj, value)
            obj = setAliasProperty(obj, 'StepTolerance', 'TolX', value);        
        end                
                
        function obj = set.SubproblemAlgorithm(obj, value)
            obj = setNewProperty(obj, 'SubproblemAlgorithm', value);
        end       

        function obj = set.TolFun(obj, value)
            obj = setNewProperty(obj, 'TolFun', value);
        end
             
        function obj = set.TolPCG(obj, value)
            obj = setProperty(obj, 'TolPCG', value);
        end        

        function obj = set.TolX(obj, value)
            obj = setProperty(obj, 'TolX', value);
        end                        
        
        function obj = set.TypicalX(obj, value)
            obj = setProperty(obj, 'TypicalX', value);
        end
        
        % ---------------------- Get methods ------------------------------
        
        function value = get.CheckGradients(obj)
            value = optim.options.OptionAliasStore.convertToLogical( ...
                        obj.OptionsStore.Options.DerivativeCheck, 'on');
        end        
        
        function value = get.DerivativeCheck(obj)
            value = obj.OptionsStore.Options.DerivativeCheck;
        end
        
        function value = get.Diagnostics(obj)
            value = obj.OptionsStore.Options.Diagnostics;
        end
        
        function value = get.DiffMaxChange(obj)
            value = obj.OptionsStore.Options.DiffMaxChange;
        end
        
        function value = get.DiffMinChange(obj)
            value = obj.OptionsStore.Options.DiffMinChange;
        end
        
        function value = get.Display(obj)
            value = obj.OptionsStore.Options.Display;
        end
        
        function value = get.FiniteDifferenceStepSize(obj)
            value = obj.OptionsStore.Options.FinDiffRelStep;
        end
        
        function value = get.FinDiffRelStep(obj)
            value = obj.OptionsStore.Options.FinDiffRelStep;
        end
        
        function value = get.FiniteDifferenceType(obj)
            value = obj.OptionsStore.Options.FinDiffType;
        end        
        
        function value = get.FinDiffType(obj)
            value = obj.OptionsStore.Options.FinDiffType;
        end
        
        function value = get.FunValCheck(obj)
            value = obj.OptionsStore.Options.FunValCheck;
        end
          
        function value = get.SpecifyObjectiveGradient(obj)
            value = optim.options.OptionAliasStore.convertToLogical( ...
                        obj.OptionsStore.Options.GradObj, 'on');
        end       
        
        function value = get.GradObj(obj)
            value = obj.OptionsStore.Options.GradObj;
        end
        
        function value = get.Hessian(obj)
            value = obj.OptionsStore.Options.Hessian;
        end

        function value = get.HessianFcn(obj)
            value = obj.OptionsStore.Options.HessFcn;
        end        
                
        function value = get.HessianMultiplyFcn(obj)
            value = obj.OptionsStore.Options.HessMult;
        end
        
        function value = get.HessMult(obj)
            value = obj.OptionsStore.Options.HessMult;
        end
        
        function value = get.HessPattern(obj)
            value = obj.OptionsStore.Options.HessPattern;
        end
        
        function value = get.HessUpdate(obj)
            value = obj.OptionsStore.Options.HessUpdate;
        end
        
        function value = get.MaxIterations(obj)
            value = obj.OptionsStore.Options.MaxIter;
        end
        
        function value = get.MaxIter(obj)
            value = obj.OptionsStore.Options.MaxIter;
        end
        
        function value = get.MaxFunctionEvaluations(obj)
            value = obj.OptionsStore.Options.MaxFunEvals;
        end        
        
        function value = get.MaxFunEvals(obj)
            value = obj.OptionsStore.Options.MaxFunEvals;
        end
        
        function value = get.MaxPCGIter(obj)
            value = obj.OptionsStore.Options.MaxPCGIter;
        end
        
        function value = get.ObjectiveLimit(obj)
            value = obj.OptionsStore.Options.ObjectiveLimit;
        end
        
        function value = get.OutputFcn(obj)
            value = obj.OptionsStore.Options.OutputFcn;
        end
        
        function value = get.PlotFcn(obj)
            value = obj.OptionsStore.Options.PlotFcns;
        end        
        
        function value = get.PlotFcns(obj)
            value = obj.OptionsStore.Options.PlotFcns;
        end
        
        function value = get.SubproblemAlgorithm(obj)
            value = optim.options.OptionAliasStore.mapOptionFromStore('SubproblemAlgorithm', obj.OptionsStore.Options);
        end
        
        function value = get.PrecondBandWidth(obj)
            value = obj.OptionsStore.Options.PrecondBandWidth;
        end
        
        function value = get.FunctionTolerance(obj)
            value = obj.OptionsStore.Options.TolFunValue;
        end        
        
        function value = get.OptimalityTolerance(obj)
            value = obj.OptionsStore.Options.TolFun;
        end        
        
        function value = get.TolFun(obj)
            value = obj.OptionsStore.Options.TolFun;
        end
        
        function value = get.TolPCG(obj)
            value = obj.OptionsStore.Options.TolPCG;
        end
        
        function value = get.StepTolerance(obj)
            value = obj.OptionsStore.Options.TolX;
        end           
        
        function value = get.TolX(obj)
            value = obj.OptionsStore.Options.TolX;
        end
        
        function value = get.TypicalX(obj)
            value = obj.OptionsStore.Options.TypicalX;
        end
        
        function value = get.UseParallel(obj)
            value = obj.OptionsStore.Options.UseParallel;
        end
        
    end
    
    % Hidden utility methods
    methods (Hidden)

        function OptionsStruct = mapOptionsForSolver(obj, OptionsStruct)
%mapOptionsForSolver Map structure to one expected by the solver
%
%   OptionsStruct = mapOptionsForSolver(obj, OptionsStruct) maps the
%   specified structure so it can be used in the solver functions and in
%   OPTIMTOOL.
%
            
            % For 17a and 17b we are keeping the LargeScale option for the
            % following structure case only:
            % optsStruct.GradObj = 'on'
            % optsStruct.LargeScale = 'on'
            % optsStruct.Algorithm = [] or 'quasi-newton'
            %
            % As LargeScale = 'on' is the default, if
            % SpecifyObjectiveGradient = true, then the trust-region
            % algorithm will be run in fminunc, regardless of the Algorithm
            % choice. 
            %
            % If a user has SpecifyObjectiveGradient = true and Algorithm =
            % 'quasi-newton', we need to set LargeScale = 'off'.
            if obj.SpecifyObjectiveGradient && strcmp(obj.Algorithm, 'quasi-newton')
                OptionsStruct.LargeScale = 'off';
            end
        end
                
        function [obj, OptimsetStruct] = mapOptimsetToOptions(obj, OptimsetStruct)
%mapOptimsetToOptions Map optimset structure to optimoptions
%
%   obj = mapOptimsetToOptions(obj, OptimsetStruct) maps specified optimset
%   options, OptimsetStruct, to the equivalent options in the specified
%   optimization object, obj.
%
%   [obj, OptimsetStruct] = mapOptimsetToOptions(obj, OptimsetStruct)
%   additionally returns an options structure modified with any conversions
%   that were performed on the options object.
            
            if isfield(OptimsetStruct,'LargeScale') && ~isempty(OptimsetStruct.LargeScale)
                % For 17a and 17b, the only case remaining where we switch
                % on LargeScale is:
                % OptimsetStruct.Gradobj = 'on'
                % OptimsetStruct.LargeScale = 'on'
                % OptimsetStruct.Algorithm = []/'quasi-newton'
                % In 18a, we can remove this mapping.
                if strcmpi(OptimsetStruct.LargeScale, 'on') && ...
                        (isfield(OptimsetStruct,'GradObj') && strcmpi(OptimsetStruct.GradObj, 'on')) && ...
                        (~isfield(OptimsetStruct,'Algorithm') || ~strcmpi(OptimsetStruct.Algorithm, 'trust-region'))                        
                    obj.Algorithm = 'trust-region';
                end
                OptimsetStruct = rmfield(OptimsetStruct,'LargeScale');
            end
            
            % Always ensure that the Algorithm option is set correctly
            if nargout > 1
                OptimsetStruct.Algorithm = obj.Algorithm;
            end
            
        end
       
        function OptionsStruct = extractOptionsStructure(obj)
%EXTRACTOPTIONSSTRUCTURE Extract options structure from OptionsStore
%
%   OPTIONSSTRUCT = EXTRACTOPTIONSSTRUCTURE(OBJ) extracts a plain structure
%   containing the options from obj.OptionsStore. The solver calls
%   convertForSolver, which in turn calls this method to obtain a plain
%   options structure.            
           
            % Call the superclass method
            OptionsStruct = extractOptionsStructure@optim.options.MultiAlgorithm(obj);
            
            % If HessFcn or HessMult are set to non-empty, this means that
            % the user will supply the Hessian via the objective function.
            % In this case we need to set the Hessian option to 'on'.
            if ~isempty(OptionsStruct.HessFcn) || ~isempty(OptionsStruct.HessMult)
                OptionsStruct.Hessian = 'on';                
            end
        end
        
    end    
    
    
    % Load old objects
    methods (Static = true)
        function obj = loadobj(obj)
            
           % Objects saved in R2013a will come in as structures. 
            if isstruct(obj) && obj.Version == 1

                % Save the existing structure
                s = obj;
                
                % Create a new object
                obj = optim.options.Fminunc;
                
                % Call the superclass method to upgrade the object
                obj = upgradeFrom13a(obj, s); 
                
                % The SolverVersion property was not present in 13a. We
                % clear it here and the remainer of loadobj will set it
                % correctly.
                obj.FminuncVersion = [];
                
            end

            % Upgrading to 13b
            % Changing default FinDiffRelStep to a string for improved
            % display -- 13b was before string support so no need to check
            % for it here
            if obj.Version == 1 && ...
                    ~ischar(obj.OptionsStore.AlgorithmDefaults{1}.FinDiffRelStep)
                
                % Change default for FinDiffRelStep
                obj.OptionsStore.AlgorithmDefaults{1}.FinDiffRelStep = 'sqrt(eps)';
                obj.OptionsStore.AlgorithmDefaults{2}.FinDiffRelStep = 'sqrt(eps)';
                
                % If FinDiffRelStep has not been set by user then change
                % option value to the default string
                if ~obj.OptionsStore.SetByUser.FinDiffRelStep
                    obj.OptionsStore.Options.FinDiffRelStep = 'sqrt(eps)';
                end
            end
            
            % Upgrading to 15b
            % Introduce FminuncVersion field
            if isempty(obj.FminuncVersion)
                % Use 'FminuncVersion' property instead of 'Version'
                % property because 'Version' is for the superclass and
                % 'FminuncVersion' is for this (derived) class. However,
                % 'FminuncVersion' was added in the second version, we
                % check only for the second version and add this property.
                % For all other version, check only the 'FminuncVersion'
                % property.
                obj.FminuncVersion = 1; % update object
            end
            
            % Upgrading to 16a
            % New properties
            if obj.FminuncVersion < 3
                
                % Add the UseParallel option to the OptionsStore
                obj.OptionsStore.AlgorithmDefaults{1}.UseParallel = false;
                obj.OptionsStore.AlgorithmDefaults{2}.UseParallel = false;
                obj.OptionsStore.SetByUser.UseParallel = false;
                obj.OptionsStore.IsConstantDefault.UseParallel = true;
                obj.OptionsStore.Options.UseParallel = false;                
                
                % Add the HessFcn option to the OptionsStore
                obj.OptionsStore.AlgorithmDefaults{1}.HessFcn = [];
                obj.OptionsStore.SetByUser.HessFcn = false;
                obj.OptionsStore.IsConstantDefault.HessFcn = true;
                obj.OptionsStore.Options.HessFcn = [];
                
                % Add the TolFunValue option to the OptionsStore
                obj.OptionsStore.AlgorithmDefaults{1}.TolFunValue = 1e-6;
                obj.OptionsStore.IsConstantDefault.TolFunValue = true;
                
                % Set TolFunValue to whatever of TolFun was saved, but only if the selected algorithm has
                % "FunctionTolerance". Otherwise, set to its default value
                % for another algorithm
                if isfield(obj.OptionsStore.AlgorithmDefaults{obj.OptionsStore.AlgorithmIndex},'TolFunValue') && obj.OptionsStore.SetByUser.TolFun
                    obj.OptionsStore.SetByUser.TolFunValue = obj.OptionsStore.SetByUser.TolFun;
                    obj.OptionsStore.Options.TolFunValue = obj.OptionsStore.Options.TolFun;
                else
                    obj.OptionsStore.SetByUser.TolFunValue = false;
                    obj.OptionsStore.Options.TolFunValue = 1e-6;
                end
                                
                % Add NumDisplayOptions and DisplayOptions fields
                obj.OptionsStore = optim.options.getDisplayOptionFieldsFor16a(...
                    obj.OptionsStore, getDefaultOptionsStore);
                
            end
            
            % Upgrading for 17a
            % Change the algorithm default
            if obj.FminuncVersion < 4
                % Change the default in the OptionsStore
                obj.OptionsStore.DefaultAlgorithm = 'quasi-newton';
                
                % If the user hasn't set the Algorithm option, keep the
                % saved value of Algorithm.
                if ~obj.OptionsStore.SetByUser.Algorithm
                    obj = setPropertyNoChecks(obj, 'Algorithm', 'trust-region');
                end
                
            end

            % Upgrading for 17b
            % Change the algorithm default
            if obj.FminuncVersion < 5
                % Remove InitialHessType and InitialHessMatrix from the
                % OptionsStore
                obj.OptionsStore.AlgorithmDefaults{2} = rmfield(...
                    obj.OptionsStore.AlgorithmDefaults{2}, ...
                    {'InitialHessType', 'InitialHessMatrix'});
                obj.OptionsStore.SetByUser = rmfield(...
                    obj.OptionsStore.SetByUser, ...
                    {'InitialHessType', 'InitialHessMatrix'});
                obj.OptionsStore.IsConstantDefault = rmfield(...
                    obj.OptionsStore.IsConstantDefault, ...
                    {'InitialHessType', 'InitialHessMatrix'});
                obj.OptionsStore.Options = rmfield(...
                    obj.OptionsStore.Options, ...
                    {'InitialHessType', 'InitialHessMatrix'});
            end
            
            % Set the version number
            obj.FminuncVersion = 5;
            
        end
    end
    
      
end

function OS = createOptionsStore
%CREATEOPTIONSSTORE Create the OptionsStore
%
%   OS = createOptionsStore creates the OptionsStore structure. This
%   structure contains the options and meta-data for option display, e.g.
%   data determining whether an option has been set by the user. This
%   function is only called when the class is first instantiated to create
%   the OptionsStore structure in its default state. Subsequent
%   instantiations of this class pick up the default OptionsStore from the
%   MCOS class definition.
%
%   Class authors must create a structure containing the following fields:-
%
%   AlgorithmNames   : Cell array of algorithm names for the solver
%   DefaultAlgorithm : String containing the name of the default algorithm
%   AlgorithmDefaults: Cell array of structures. AlgorithmDefaults{i}
%                      holds a structure containing the defaults for 
%                      AlgorithmNames{i}.
%
%   This structure must then be passed to the
%   optim.options.generateMultiAlgorithmOptionsStore function to create
%   the full OptionsStore. See below for an example for Fminunc.

% Continue OptionsStore
% Define the algorithm names
% Alphabetical order
% Define the algorithm names
OS.AlgorithmNames = optim.options.Fminunc.PropertyMetaInfo.Algorithm.Values;

% Define the default algorithm
OS.DefaultAlgorithm = 'quasi-newton';

% Define the defaults for each algorithm       
% trust-region-reflective
OS.AlgorithmDefaults{1}.DerivativeCheck = 'off';
OS.AlgorithmDefaults{1}.Diagnostics = 'off';
OS.AlgorithmDefaults{1}.DiffMaxChange = Inf;
OS.AlgorithmDefaults{1}.DiffMinChange = 0;
OS.AlgorithmDefaults{1}.Display = 'final';
OS.AlgorithmDefaults{1}.FinDiffRelStep = 'sqrt(eps)';
OS.AlgorithmDefaults{1}.FinDiffType = 'forward';
OS.AlgorithmDefaults{1}.FunValCheck = 'off';
OS.AlgorithmDefaults{1}.GradObj = 'off';
OS.AlgorithmDefaults{1}.Hessian = 'off';
OS.AlgorithmDefaults{1}.HessFcn = [];
OS.AlgorithmDefaults{1}.HessMult = [];
OS.AlgorithmDefaults{1}.HessPattern = 'sparse(ones(numberOfVariables))';
OS.AlgorithmDefaults{1}.MaxFunEvals = '100*numberOfVariables';
OS.AlgorithmDefaults{1}.MaxIter = 400;
OS.AlgorithmDefaults{1}.MaxPCGIter = 'max(1,floor(numberOfVariables/2))';
OS.AlgorithmDefaults{1}.OutputFcn= [];
OS.AlgorithmDefaults{1}.PlotFcns= [];
OS.AlgorithmDefaults{1}.PrecondBandWidth = 0;
OS.AlgorithmDefaults{1}.TolFun = 1.0000e-06;
OS.AlgorithmDefaults{1}.TolFunValue = 1.0000e-06;
OS.AlgorithmDefaults{1}.TolPCG = 0.1;
OS.AlgorithmDefaults{1}.TolX = 1e-6;
OS.AlgorithmDefaults{1}.TypicalX = 'ones(numberOfVariables,1)';
OS.AlgorithmDefaults{1}.UseParallel = false;

% line-search
OS.AlgorithmDefaults{2}.DerivativeCheck = 'off';
OS.AlgorithmDefaults{2}.Diagnostics = 'off';
OS.AlgorithmDefaults{2}.DiffMaxChange = Inf;
OS.AlgorithmDefaults{2}.DiffMinChange = 0;
OS.AlgorithmDefaults{2}.Display = 'final';
OS.AlgorithmDefaults{2}.FinDiffRelStep = 'sqrt(eps)';
OS.AlgorithmDefaults{2}.FinDiffType = 'forward';
OS.AlgorithmDefaults{2}.FunValCheck = 'off';
OS.AlgorithmDefaults{2}.GradObj = 'off';
OS.AlgorithmDefaults{2}.HessUpdate = 'bfgs';
OS.AlgorithmDefaults{2}.MaxFunEvals = '100*numberOfVariables';
OS.AlgorithmDefaults{2}.MaxIter = 400;
OS.AlgorithmDefaults{2}.ObjectiveLimit = -1e20;
OS.AlgorithmDefaults{2}.OutputFcn= [];
OS.AlgorithmDefaults{2}.PlotFcns= [];
OS.AlgorithmDefaults{2}.TolFun = 1.0000e-06;
OS.AlgorithmDefaults{2}.TolX = 1e-6;
OS.AlgorithmDefaults{2}.TypicalX = 'ones(numberOfVariables,1)';
OS.AlgorithmDefaults{2}.UseParallel = false;

% Call the package function to generate the OptionsStore
OS = optim.options.generateMultiAlgorithmOptionsStore(OS, 'optim.options.Fminunc');

end

function os = getDefaultOptionsStore

persistent thisos

if isempty(thisos)
    opts = optim.options.Fminunc;
    thisos = getOptionsStore(opts);
end
    
os = thisos;

end

function propInfo = genPropInfo()
    % Helper function to generate constant property metadata for the Fminunc
    % options class.
    import optim.internal.TypeInfo;
    propInfo.Algorithm = TypeInfo.enumType({'trust-region','quasi-newton'});
    propInfo.CheckGradients = TypeInfo.logicalType();
    propInfo.Display = TypeInfo.enumType({'off','iter','iter-detailed','notify','notify-detailed','final','final-detailed'});
    propInfo.FiniteDifferenceStepSize = TypeInfo.numericType();
    propInfo.FiniteDifferenceType = TypeInfo.enumType({'forward','central'});
    propInfo.FunctionTolerance = TypeInfo.numericType();
    propInfo.HessianFcn = TypeInfo.fcnEnumType({'objective'});
    propInfo.HessianMultiplyFcn = TypeInfo.fcnType();
    propInfo.MaxFunctionEvaluations = TypeInfo.integerType();
    propInfo.MaxIterations = TypeInfo.integerType();
    propInfo.ObjectiveLimit = TypeInfo.numericType();
    propInfo.OptimalityTolerance = TypeInfo.numericType();
    propInfo.OutputFcn = TypeInfo.fcnOrEmptyType();
    propInfo.PlotFcn = TypeInfo.fcnEnumType({'optimplotx', 'optimplotfunccount', 'optimplotfval', 'optimplotstepsize', 'optimplotfirstorderopt'});
    propInfo.SpecifyObjectiveGradient = TypeInfo.logicalType();
    propInfo.StepTolerance = TypeInfo.numericType();
    propInfo.SubproblemAlgorithm = TypeInfo.enumType({'cg','ldl-factorization'});
    propInfo.TypicalX = TypeInfo.numericType();
end
