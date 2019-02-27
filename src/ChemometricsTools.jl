module ChemometricsTools
    using CSV: read
    using LinearAlgebra
    using Distributions #Could probably also get rid of this one...
    using Statistics
    using StatsBase
    using Plots
    using DSP: conv #Ew I wanna get rid of this dependency... One function uses it...

    #A generic function that I use everywhere...
    forceMatrix( a ) = ( length( size( a ) ) == 1 ) ? reshape( a, length(a), 1 ) : a
    export forceMatrix

    include("InHouseStats.jl")
    export EmpiricalQuantiles, Update!, Remove!, Update, Remove, RunningMean,
        rbinomial

    include("ClassificationMetrics.jl")
    export LabelEncoding, IsColdEncoded, HotToCold, ColdToHot, MulticlassStats,
        Threshold, MulticlassThreshold, HighestVote

    include("RegressionMetrics.jl")
    export ME, MAE, MAPE, SSE, MSE, RMSE, SSTotal, SSReg, SSRes, RSquare,
        PearsonCorrelationCoefficient, PercentRMSE

    include("DistanceMeasures.jl")
    export SquareEuclideanDistance, EuclideanDistance, ManhattanDistance,
        GaussianKernel, LinearKernel, Kernel

    include("Transformations.jl")
    export Transform, PipelineInPlace, Pipeline, QuantileTrim, Center, Scale,
        CenterScale, RangeNorm, Logit, BoxCox

    include("Analysis.jl")
    export PCA_NIPALS, PCA, LDA, CanonicalCorrelationAnalysis, ExplainedVariance,
        findpeaks

    include("AnomalyDetection.jl")
    export OneClassJKNN, Q, Hotelling, Leverage

    include("ClassificationModels.jl")
    export KNN, GaussianDiscriminant, LogisticRegression, MultinomialSoftmaxRegression,
        GaussianNaiveBayes, HighestVoteOneHot

    include("Clustering.jl")
    export TotalClusterSS, WithinClusterSS, BetweenClusterSS,
        KMeansClustering, KMeans

    include("Preprocess.jl")
    export FirstDerivative, SecondDerivative, FractionalDerivative, SavitzkyGolay,
        DirectStandardization, OrthogonalSignalCorrection, MultiplicativeScatterCorrection,
        StandardNormalVariate, Scale1Norm, Scale2Norm, ScaleInfNorm, boxcarScaleMinMax,
        offsetToZero
        #,TransferByOrthogonalProjection

    include("RegressionModels.jl")
    export ClassicLeastSquares, RidgeRegression, PrincipalComponentRegression,
        PartialLeastSquares, KernelRidgeRegression, LSSVM, ExtremeLearningMachine, PredictFn, sigmoid

    include("Trees.jl")
    export OneHotOdds, entropy, gini, ssd, StumpOrNode, ClassificationTree, RegressionTree, CART

    include("Ensembles.jl")
    export MakeInterval, MakeIntervals, stackedweights, RandomForest

    include("Sampling.jl")
    export VenetianBlinds, SplitByProportion, KennardStone

    include("Training.jl")
    export Shuffle, Shuffle!, LeaveOneOut, KFoldsValidation

    include("PSO.jl")
    export PSO, Particle, Bounds

    include("CurveResolution.jl")
    export BTEMobjective, BTEM, NMF, SIMPLISMA, MCRALS, FNNLS

    include("PlottingTools.jl")
    export QQ, BlandAltman, plotchem, rectangle, IntervalOverlay

    include("TimeSeries.jl")
    export RollingWindow, EchoStateNetwork, TuneRidge, PredictFn

    #Generic function for pulling data from within this package.
    #If enough datasets are provided then the data/dataloading could be a seperate package...
    #This will remain hard-coded until I have atleast 2 datasets that require permissions...
    TecatorStatement = "Statement of permission from Tecator (the original data source).These data are recorded on a Tecator" *
    "\n Infratec Food and Feed Analyzer working in the wavelength range 850 - 1050 nm by the Near Infrared" *
    "\n Transmission (NIT) principle. Each sample contains finely chopped pure meat with different moisture, fat" *
    "\n and protein contents.If results from these data are used in a publication we want you to mention the" *
    "\n instrument and company name (Tecator) in the publication. In addition, please send a preprint of your " *
    "\n article to Karin Thente, Tecator AB, Box 70, S-263 21 Hoganas, Sweden. The data are available in the " *
    "\n public domain with no responsability from the original data source. The data can be redistributed as long " *
    "\n as this permission note is attached. For more information about the instrument - call Perstorp Analytical's" *
    "\n representative in your area."

    datapath = joinpath(@__DIR__, "..", "data")
    ChemometricsToolsDatasets() = begin
        dircontents = readdir(datapath)
        dircontents = [ f for f in dircontents if f != "Readme.md" ]
        return Dict( (1:length(dircontents)) .=> dircontents )
    end
    function ChemometricsToolsDataset(filename::String)
        if filename == "tecator.csv"
            println(TecatorStatement)
        end
        if filename != "Readme.md"
            read( Base.joinpath( datapath, filename ) )
        else
            println("Don't load the markdown Readme as a csv... You're better than this.")
        end
    end
    function ChemometricsToolsDataset(file::Int)
        if readdir(datapath)[file] == "tecator.csv"
            println(TecatorStatement)
        end
        read( Base.joinpath( datapath, readdir(datapath)[file] ) )
    end
    export ChemometricsToolsDataset, ChemometricsToolsDatasets
    #ToDo: Add more unit tests to test/runtests.jl...

end # module
