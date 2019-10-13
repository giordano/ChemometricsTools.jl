module ChemometricsTools
    using DataFrames, LinearAlgebra, Statistics, StatsBase, SparseArrays,
            RecipesBase, Distributions, Dates, Revise
    using CSV: read
    #A generic function that I use everywhere to coerce a vector dim 0 to a row vector...
    forceMatrix( a ) = ( length( size( a ) ) == 1 ) ? reshape( a, length(a), 1 ) : a
    forceMatrixT( a ) = ( length( size( a ) ) == 1 ) ? reshape( a, 1, length(a) ) : a
    export forceMatrix, forceMatrixT

    include("InHouseStats.jl") #Has Docs
    export EmpiricalQuantiles, Update!, Remove!, Update, Remove, RunningMean, RunningVar,
        Variance, Mean, rbinomial, Skewness, SampleSkewness, PermutedVectorPair

    include("ClassificationMetrics.jl") #Has Docs
    export LabelEncoding, IsColdEncoded, HotToCold, ColdToHot, MulticlassStats,
        Threshold, MulticlassThreshold, HighestVote, StatsFromTFPN, StatsDictToDataFrame,
        StatsToCSVs, DataFrameToLaTeX, StatsToLaTeX

    include("RegressionMetrics.jl") #Has Docs
    export ME, MAE, MAPE, SSE, MSE, RMSE, SSTotal, SSReg, SSRes, RSquare,
        PearsonCorrelationCoefficient, PercentRMSE, FNorm

    include("DistanceMeasures.jl") #Has Docs
    export SquareEuclideanDistance, EuclideanDistance, ManhattanDistance,
        MinkowskiDistance, LevenshteinDistance, GaussianKernel, CauchyKernel,
        LinearKernel, Kernel, NearestNeighbors, AdjacencyMatrix,
        InClassAdjacencyMatrix, OutOfClassAdjacencyMatrix, CenterKernelMatrix

    include("Transformations.jl") #Has Docs: Box Cox Omitted for now...
    export Transform, PipelineInPlace, Pipeline, QuantileTrim, Center, Scale,
        CenterScale, RangeNorm, Logit, BoxCox

    include("Analysis.jl") #Has Docs
    export PCA_NIPALS, PCA, LDA, CanonicalCorrelationAnalysis, findpeaks,
        RAFFT, AssessHealth

    include("AnomalyDetection.jl") #Has docs
    export OneClassJKNN

    include("ClassificationModels.jl") #Has docs
    export KNN, ProbabilisticNeuralNetwork, GaussianDiscriminant, LogisticRegression, MultinomialSoftmaxRegression,
        GaussianNaiveBayes, HighestVoteOneHot, ConfidenceEllipse, LinearPerceptronSGD, LinearPerceptronBatch,
        HLDA

    include("Clustering.jl") #Has Docs
    export TotalClusterSS, WithinClusterSS, BetweenClusterSS, KMeansClustering, KMeans

    include("Preprocess.jl") #Has Docs
    export FirstDerivative, SecondDerivative, FractionalDerivative, SavitzkyGolay,
        DirectStandardization, OrthogonalSignalCorrection, MultiplicativeScatterCorrection,
        StandardNormalVariate, Scale1Norm, Scale2Norm, ScaleInfNorm, ScaleFNorm,
        ScaleMinMax, ScaleByIntensity, offsetToZero, boxcar, ALSSmoother,
        PerfectSmoother, CORAL, TransferByOrthogonalProjection, Noise

    include("RegressionModels.jl") # Has Docs
    export ClassicLeastSquares, OrdinaryLeastSquares, RidgeRegression,
        PrincipalComponentRegression, PartialLeastSquares, KernelRidgeRegression,
        LSSVM, ExtremeLearningMachine, PredictFn, sigmoid,
        MonotoneRegression

    include("ModelAnalysis.jl") #Has Docs - Not displaying?
    export ExplainedVariance, ExplainedVarianceX, ExplainedVarianceY,
            Q, Hotelling, Leverage

    include("Trees.jl") #Has Docs: Omitted StumpOrNode & StumpOrNodeRegress
    export OneHotOdds, entropy, gini, ssd, ClassificationTree, RegressionTree, CART

    include("Ensembles.jl") #Has Docs
    export MakeIntervals, stackedweights, RandomForest

    include("Sampling.jl") #Has Docs
    export VenetianBlinds, SplitByProportion, KennardStone

    include("Training.jl") #Has Docs
    export Shuffle, Shuffle!, LeaveOneOut, KFoldsValidation

    include("PSO.jl") #Has docs
    export PSO, Particle, Bounds

    include("CurveResolution.jl") #Has Docs
    export BTEMobjective, BTEM, NMF, SIMPLISMA, MCRALS, FNNLS, UnimodalFixedUpdate,
        UnimodalUpdate, UnimodalLeastSquares

    include("PlottingTools.jl") #Has Docs
    export residualsplotrecipe, QQ, BlandAltman, IntervalOverlay,
        DiscriminantAnalysisPlot, DAPlot

    include("TimeSeries.jl") #Has Docs: Omitted EchoStateNetwork Fns
    export RollingWindow, EchoStateNetwork, TuneRidge, PredictFn, EWMA, Variance, Limits, update,
        SimpleAverage, NaiveForecast, update!, update

    include("MultiWay.jl") #Has Docs
    export Unfold, MultiCenter, MultiScale, MultiNorm, MultilinearPCA, HOSVD, HOOI,
        TensorProduct, MultilinearPLS

    include("KernelDensityGenerator.jl") #Has Docs
    export Universe, SpectralArray, GaussianBand, LorentzianBand

    include("SimpleGAs.jl") #Has Docs
    export BinaryLifeform, Lifeform, SinglePointCrossOver, Mutate

    include("DataUtils.jl") #Has Docs
    export ChemometricsToolsDataset, ChemometricsToolsDatasets,
        FindCommonVariables

end # module
