#!/usr/bin/env julia

#Start Test Script
using ChemometricsTools
using Test
#Pkg.test("ChemometricsTools")
#Pkg.test()

#FNNLS tests...
# a = reshape( [73,111,52,87, 7,4, 46,72,27,80,89 , 71], 4,3)
# b = [96,7, 68,10]
# FNNLS(a, b)

# a = randn(4,4);
# b = randn(4);
# x = FNNLS( a,  b)
#
# #Torture test...
# counterrs = 0
# for i in 1:10000
#     a = randn(4,4);
#     b = randn(4);
#     x = FNNLS( a,  b)
#     if any(x .< -1e-2)
#         counterrs += 1
#     end
# end
# counterrs



@testset "Transformations" begin
    simplearray = [[1,2,3] [1,2,3]];
    Xform = Center( simplearray )
    @test all( Xform( simplearray ) .== [ [-1,0,1] [-1,0,1] ] )
end

@testset "Pipelines" begin
    #Test a longish pipeline
    FauxData1 = randn(5,10);
    PreprocessPipe = Pipeline(FauxData1, RangeNorm, Center, Scale, RangeNorm);
    Processed = PreprocessPipe(FauxData1);
    @test RMSE( FauxData1, PreprocessPipe(Processed; inverse = true) ) < 1e-14

    #Test inplace pipeline
    OriginalCopy = copy(FauxData1);
    InPlacePipe = PipelineInPlace(FauxData1, RangeNorm, Center, Scale, RangeNorm);
    @test FauxData1 != OriginalCopy
    @test Processed == FauxData1
    #Inplace transform the data back
    InPlacePipe(FauxData1; inverse = true)
    @test RMSE( OriginalCopy, FauxData1 ) < 1e-14

    #Ensure that centerscale center then scales
    Pipe1 = Pipeline(FauxData1, Center, Scale);
    Pipe2 = Pipeline(FauxData1, CenterScale);
    @test RMSE( Pipe1(FauxData1), Pipe2(FauxData1) ) < 1e-14

    #Logit can Inf out pretty easily so test with a small vector
    FauxData2 = [1,1,2,3,4,5,6,7] ./ 10.0;
    Pipe1 = Pipeline(FauxData2,  Logit);
    @test RMSE( FauxData2, Pipe1(Pipe1(FauxData2); inverse = true) ) < 1e-14
end
