using GeoStatsVizTests
using GeoTables
using Meshes
using Distributions
using Unitful
using Colors
using ReferenceTests
using Random
using Test

import CairoMakie as Mke

datadir = joinpath(@__DIR__, "data")

rng = MersenneTwister(2)

@testset "GeoStatsVizTests.jl" begin
  @testset "viz" begin
    # 1D point set
    p = PointSet(Point1[(0.0,), (1.0,), (2.0,), (3.0,)])
    @test_reference joinpath(datadir, "pset1D-1.png") viz(p)
    @test_reference joinpath(datadir, "pset1D-2.png") viz(p, color=:red)
    @test_reference joinpath(datadir, "pset1D-3.png") viz(p, color=1:4)
    @test_reference joinpath(datadir, "pset1D-4.png") viz(p, color=1:4, colorscheme=:inferno)
    @test_reference joinpath(datadir, "pset1D-5.png") viz(p, color=:red, alpha=0.5)
    @test_reference joinpath(datadir, "pset1D-6.png") viz(p, color=1:4, alpha=0.5)

    # 2D point set
    p = PointSet(Point2[(0.0, 0.0), (1.0, 0.0), (1.0, 1.0), (0.0, 1.0)])
    @test_reference joinpath(datadir, "pset2D-1.png") viz(p)
    @test_reference joinpath(datadir, "pset2D-2.png") viz(p, color=:red)
    @test_reference joinpath(datadir, "pset2D-3.png") viz(p, color=1:4)
    @test_reference joinpath(datadir, "pset2D-4.png") viz(p, color=1:4, colorscheme=:inferno)
    @test_reference joinpath(datadir, "pset2D-5.png") viz(p, color=:red, alpha=0.5)
    @test_reference joinpath(datadir, "pset2D-6.png") viz(p, color=1:4, alpha=0.5)

    # 3D point set
    p = PointSet(
      Point3[
        (0.0, 0.0, 0.0),
        (1.0, 0.0, 0.0),
        (1.0, 1.0, 0.0),
        (0.0, 1.0, 0.0),
        (0.0, 0.0, 1.0),
        (1.0, 0.0, 1.0),
        (1.0, 1.0, 1.0),
        (0.0, 1.0, 1.0)
      ]
    )
    @test_reference joinpath(datadir, "pset3D-1.png") viz(p)
    @test_reference joinpath(datadir, "pset3D-2.png") viz(p, color=:red)
    @test_reference joinpath(datadir, "pset3D-3.png") viz(p, color=1:8)
    @test_reference joinpath(datadir, "pset3D-4.png") viz(p, color=1:8, colorscheme=:inferno)
    @test_reference joinpath(datadir, "pset3D-5.png") viz(p, color=:red, alpha=0.5)
    @test_reference joinpath(datadir, "pset3D-6.png") viz(p, color=1:8, alpha=0.5)

    # 2D Cartesian grid
    d = CartesianGrid(10, 10)
    @test_reference joinpath(datadir, "grid2D-1.png") viz(d)
    @test_reference joinpath(datadir, "grid2D-2.png") viz(d, showfacets=true)
    @test_reference joinpath(datadir, "grid2D-3.png") viz(d, showfacets=true, facetcolor=:red)
    @test_reference joinpath(datadir, "grid2D-4.png") viz(d, color=1:100)
    @test_reference joinpath(datadir, "grid2D-5.png") viz(d, color=1:100, colorscheme=:inferno)
    @test_reference joinpath(datadir, "grid2D-6.png") viz(d, color=:red)
    @test_reference joinpath(datadir, "grid2D-7.png") viz(d, color=:red, alpha=0.5)
    @test_reference joinpath(datadir, "grid2D-8.png") viz(d, color=1:100, alpha=0.5)
    @test_reference joinpath(datadir, "grid2D-9.png") viz(d, color=1:100, showfacets=true)
    @test_reference joinpath(datadir, "grid2D-10.png") viz(d, color=1:100, showfacets=true, facetcolor=:red)
    @test_reference joinpath(datadir, "grid2D-11.png") viz(d, showfacets=true, segmentsize=5)
    @test_reference joinpath(datadir, "grid2D-12.png") viz(d, showfacets=true, facetcolor=:red, segmentsize=5)

    # 3D Cartesian grid
    d = CartesianGrid(10, 10, 10)
    @test_reference joinpath(datadir, "grid3D-1.png") viz(d)
    @test_reference joinpath(datadir, "grid3D-2.png") viz(d, showfacets=true)
    @test_reference joinpath(datadir, "grid3D-3.png") viz(d, showfacets=true, facetcolor=:red)
    @test_reference joinpath(datadir, "grid3D-4.png") viz(d, color=1:1000)
    @test_reference joinpath(datadir, "grid3D-5.png") viz(d, color=1:1000, colorscheme=:inferno)
    @test_reference joinpath(datadir, "grid3D-6.png") viz(d, color=:red)
    @test_reference joinpath(datadir, "grid3D-7.png") viz(d, color=:red, alpha=0.5)
    @test_reference joinpath(datadir, "grid3D-8.png") viz(d, color=1:1000, alpha=0.5)
    @test_reference joinpath(datadir, "grid3D-9.png") viz(d, color=1:1000, showfacets=true)
    @test_reference joinpath(datadir, "grid3D-10.png") viz(d, color=1:1000, showfacets=true, facetcolor=:red)
    @test_reference joinpath(datadir, "grid3D-11.png") viz(d, showfacets=true, segmentsize=5)
    @test_reference joinpath(datadir, "grid3D-12.png") viz(d, showfacets=true, facetcolor=:red, segmentsize=5)

    # 2D chain
    c = Rope((0.0, 0.0), (1.0, 0.5), (1.0, 1.0), (2.0, 0.0))
    @test_reference joinpath(datadir, "chain2D-1.png") viz(c)
    @test_reference joinpath(datadir, "chain2D-2.png") viz(c, color=:orange)
    c = Ring((0.0, 0.0), (1.0, 0.5), (1.0, 1.0), (2.0, 0.0))
    @test_reference joinpath(datadir, "chain2D-3.png") viz(c)
    @test_reference joinpath(datadir, "chain2D-4.png") viz(c, color=:orange)
    @test_reference joinpath(datadir, "chain2D-5.png") viz(c, segmentsize=5)
    @test_reference joinpath(datadir, "chain2D-6.png") viz(c, color=:orange, segmentsize=5)
    c = Rope((1.0, 0.5), (1.0, 1.0), (2.0, 0.0), (0.0, 0.0))
    @test_reference joinpath(datadir, "chain2D-7.png") viz(c, showfacets=true)
    @test_reference joinpath(datadir, "chain2D-8.png") viz(c, showfacets=true, facetcolor=:red)
    @test_reference joinpath(datadir, "chain2D-9.png") viz(c, showfacets=true, pointsize=20)
    @test_reference joinpath(datadir, "chain2D-10.png") viz(c, showfacets=true, facetcolor=:red, pointsize=20)

    # 2D N-gons
    t = Triangle((1.0, 0.0), (2.0, 0.0), (2.0, 1.0))
    @test_reference joinpath(datadir, "tri2D-1.png") viz(t)
    @test_reference joinpath(datadir, "tri2D-2.png") viz(t, showfacets=true)
    @test_reference joinpath(datadir, "tri2D-3.png") viz(t, color=:orange)
    @test_reference joinpath(datadir, "tri2D-4.png") viz(t, color=:cyan, showfacets=true, facetcolor=:red)
    @test_reference joinpath(datadir, "tri2D-5.png") viz(t, color=:orange, alpha=0.5)
    @test_reference joinpath(datadir, "tri2D-6.png") viz(t, showfacets=true, segmentsize=5)
    @test_reference joinpath(datadir, "tri2D-7.png") viz(t, showfacets=true, facetcolor=:red, segmentsize=5)
    q = Quadrangle((0.0, 0.0), (1.0, 0.0), (1.0, 1.0), (0.0, 1.0))
    @test_reference joinpath(datadir, "quad2D-1.png") viz(q)
    @test_reference joinpath(datadir, "quad2D-2.png") viz(q, showfacets=true)
    @test_reference joinpath(datadir, "quad2D-3.png") viz(q, color=:orange)
    @test_reference joinpath(datadir, "quad2D-4.png") viz(q, color=:cyan, showfacets=true, facetcolor=:red)
    @test_reference joinpath(datadir, "quad2D-5.png") viz(q, color=:orange, alpha=0.5)
    @test_reference joinpath(datadir, "quad2D-6.png") viz(q, showfacets=true, segmentsize=5)
    @test_reference joinpath(datadir, "quad2D-7.png") viz(q, showfacets=true, facetcolor=:red, segmentsize=5)

    # 3D N-gons
    o = Octagon(
      (0.0, 0.0, 1.0),
      (0.5, -0.5, 0.0),
      (1.0, 0.0, 0.0),
      (1.5, 0.5, -0.5),
      (1.0, 1.0, 0.0),
      (0.5, 1.5, 0.0),
      (0.0, 1.0, 0.0),
      (-0.5, 0.5, 0.0)
    )
    @test_reference joinpath(datadir, "oct3D-1.png") viz(o)
    @test_reference joinpath(datadir, "oct3D-2.png") viz(o, showfacets=true)
    @test_reference joinpath(datadir, "oct3D-3.png") viz(o, color=:orange)
    @test_reference joinpath(datadir, "oct3D-4.png") viz(o, color=:cyan, showfacets=true, facetcolor=:red)
    @test_reference joinpath(datadir, "oct3D-5.png") viz(o, color=:orange, alpha=0.5)

    # Polygonal areas
    Random.seed!(2020)
    p = PolyArea((0.0, 0.0), (0.5, -1.5), (1.0, 0.0), (1.5, 0.5), (1.0, 1.0), (0.5, 1.5), (-0.5, 0.5))
    @test_reference joinpath(datadir, "poly2D-1.png") viz(p)
    @test_reference joinpath(datadir, "poly2D-2.png") viz(p, showfacets=true)
    @test_reference joinpath(datadir, "poly2D-3.png") viz(p, color=:orange)
    @test_reference joinpath(datadir, "poly2D-4.png") viz(p, color=:cyan, showfacets=true, facetcolor=:red)
    @test_reference joinpath(datadir, "poly2D-5.png") viz(p, color=:orange, alpha=0.5)

    # Multi-geometries
    t = Triangle((1.0, 0.0), (2.0, 0.0), (2.0, 1.0))
    q = Quadrangle((0.0, 0.0), (1.0, 0.0), (1.0, 1.0), (0.0, 1.0))
    m = Multi([t, q])
    @test_reference joinpath(datadir, "multi2D-1.png") viz(m)
    @test_reference joinpath(datadir, "multi2D-2.png") viz(m, showfacets=true)
    @test_reference joinpath(datadir, "multi2D-3.png") viz(m, color=:orange)
    @test_reference joinpath(datadir, "multi2D-4.png") viz(m, color=:cyan, showfacets=true, facetcolor=:red)
    @test_reference joinpath(datadir, "multi2D-5.png") viz(m, color=:orange, alpha=0.5)

    # 2D boxes
    b = Box((0.0, 0.0), (1.0, 1.0))
    @test_reference joinpath(datadir, "box2D-1.png") viz(b)
    @test_reference joinpath(datadir, "box2D-2.png") viz(b, showfacets=true)
    @test_reference joinpath(datadir, "box2D-3.png") viz(b, color=:orange)
    @test_reference joinpath(datadir, "box2D-4.png") viz(b, color=:cyan, showfacets=true, facetcolor=:red)
    @test_reference joinpath(datadir, "box2D-5.png") viz(b, color=:orange, alpha=0.5)

    # 3D boxes
    b = Box((0.0, 0.0, 0.0), (1.0, 1.0, 1.0))
    @test_reference joinpath(datadir, "box3D-1.png") viz(b)
    @test_reference joinpath(datadir, "box3D-2.png") viz(b, color=:orange)
    @test_reference joinpath(datadir, "box3D-3.png") viz(b, color=:orange, alpha=0.5)

    # 2D bezier
    b = BezierCurve((0.0, 0.0), (1.0, 0.0), (1.0, 1.0))
    @test_reference joinpath(datadir, "bezier2D-1.png") viz(b)
    @test_reference joinpath(datadir, "bezier2D-2.png") viz(b, color=:orange)
    @test_reference joinpath(datadir, "bezier2D-3.png") viz(b, color=:orange, alpha=0.5)

    # 3D bezier
    b = BezierCurve((0.0, 0.0, 0.0), (1.0, 0.0, 0.0), (1.0, 1.0, 1.0))
    @test_reference joinpath(datadir, "bezier3D-1.png") viz(b)
    @test_reference joinpath(datadir, "bezier3D-2.png") viz(b, color=:orange)
    @test_reference joinpath(datadir, "bezier3D-3.png") viz(b, color=:orange, alpha=0.5)

    # 2D balls
    b = Ball((0.0, 0.0), 1.0)
    @test_reference joinpath(datadir, "ball2D-1.png") viz(b)
    @test_reference joinpath(datadir, "ball2D-2.png") viz(b, showfacets=true)
    @test_reference joinpath(datadir, "ball2D-3.png") viz(b, color=:orange)
    @test_reference joinpath(datadir, "ball2D-4.png") viz(b, color=:cyan, showfacets=true, facetcolor=:red)
    @test_reference joinpath(datadir, "ball2D-5.png") viz(b, color=:orange, alpha=0.5)

    # 2D spheres
    s = Sphere((0.0, 0.0), 1.0)
    @test_reference joinpath(datadir, "sphere2D-1.png") viz(s)
    @test_reference joinpath(datadir, "sphere2D-2.png") viz(s, color=:orange)
    @test_reference joinpath(datadir, "sphere2D-3.png") viz(s, color=:orange, alpha=0.5)

    # 3D spheres
    s = Sphere((0.0, 0.0, 0.0), 1.0)
    @test_reference joinpath(datadir, "sphere3D-1.png") viz(s)
    @test_reference joinpath(datadir, "sphere3D-2.png") viz(s, color=:orange)
    @test_reference joinpath(datadir, "sphere3D-3.png") viz(s, color=:orange, alpha=0.5)

    # cylinders
    c = Cylinder(1.0)
    @test_reference joinpath(datadir, "cylinder3D-1.png") viz(c)
    @test_reference joinpath(datadir, "cylinder3D-2.png") viz(c, color=:orange)
    @test_reference joinpath(datadir, "cylinder3D-3.png") viz(c, color=:orange, alpha=0.5)
    c = Cylinder((1.0, 0.0, 0.0), (1.0, 1.0, 1.0), 1.0)
    @test_reference joinpath(datadir, "cylinder3D-4.png") viz(c)
    @test_reference joinpath(datadir, "cylinder3D-5.png") viz(c, color=:orange)
    @test_reference joinpath(datadir, "cylinder3D-6.png") viz(c, color=:orange, alpha=0.5)

    # cylinder surface
    c = CylinderSurface((1.0, 0.0, 0.0), (1.0, 1.0, 1.0), 1.0)
    @test_reference joinpath(datadir, "cylsurf3D-1.png") viz(c)
    @test_reference joinpath(datadir, "cylsurf3D-2.png") viz(c, color=:orange)
    @test_reference joinpath(datadir, "cylsurf3D-3.png") viz(c, color=:orange, alpha=0.5)

    # collections of 1D geometries
    c1 = Rope((0.0, 0.0), (1.0, 1.0), (0.0, 1.0))
    c2 = Rope((1.0, 1.0), (2.0, 2.0), (1.0, 2.0))
    c = GeometrySet([c1, c2])
    @test_reference joinpath(datadir, "collec1D-1.png") viz(c)
    @test_reference joinpath(datadir, "collec1D-2.png") viz(c, color=1:2)
    @test_reference joinpath(datadir, "collec1D-3.png") viz(c, color=1:2, colorscheme=:inferno)
    @test_reference joinpath(datadir, "collec1D-4.png") viz(c, color=[:red, :green], alpha=0.5)
    @test_reference joinpath(datadir, "collec1D-5.png") viz(c, color=1:2, alpha=0.5)

    # collections of 2D geometries
    t = Triangle((1.0, 0.0), (2.0, 0.0), (2.0, 1.0))
    q = Quadrangle((0.0, 0.0), (1.0, 0.0), (1.0, 1.0), (0.0, 1.0))
    d = GeometrySet([t, q])
    @test_reference joinpath(datadir, "collec2D-1.png") viz(d)
    @test_reference joinpath(datadir, "collec2D-2.png") viz(d, showfacets=true)
    @test_reference joinpath(datadir, "collec2D-3.png") viz(d, showfacets=true, facetcolor=:red)
    @test_reference joinpath(datadir, "collec2D-4.png") viz(d, color=1:2)
    @test_reference joinpath(datadir, "collec2D-5.png") viz(d, color=1:2, colorscheme=:inferno)
    @test_reference joinpath(datadir, "collec2D-6.png") viz(d, color=[:red, :green], alpha=0.5)
    @test_reference joinpath(datadir, "collec2D-7.png") viz(d, color=1:2, alpha=0.5)

    # collections of 3D multi-geometries
    b1 = Box((0.0, 0.0, 0.0), (1.0, 1.0, 1.0))
    b2 = Box((2.0, 1.0, 0.0), (3.0, 2.0, 1.0))
    s1 = Ball((3.0, 0.0, 3.0), 1.0)
    s2 = Ball((-1.0, 0.0, -1.0), 1.0)
    m1 = Multi([b1, b2])
    m2 = Multi([s1, s2])
    d = GeometrySet([m1, m2])
    @test_reference joinpath(datadir, "collec3D-1.png") viz(d)
    @test_reference joinpath(datadir, "collec3D-2.png") viz(d, color=1:2)
    @test_reference joinpath(datadir, "collec3D-3.png") viz(d, color=1:2, colorscheme=:inferno)
    @test_reference joinpath(datadir, "collec3D-4.png") viz(d, color=[:red, :green], alpha=0.5)
    @test_reference joinpath(datadir, "collec3D-5.png") viz(d, color=1:2, alpha=0.5)

    # surface meshes
    s = Sphere((0.0, 0.0, 0.0), 1.0)
    m = discretize(s, RegularDiscretization(10))
    nv = nvertices(m)
    ne = nelements(m)
    @test_reference joinpath(datadir, "surf3D-1.png") viz(m)
    @test_reference joinpath(datadir, "surf3D-2.png") viz(m, color=1:nv)
    @test_reference joinpath(datadir, "surf3D-3.png") viz(m, color=1:ne)
    @test_reference joinpath(datadir, "surf3D-4.png") viz(m, color=1:ne, showfacets=true)
    @test_reference joinpath(datadir, "surf3D-5.png") viz(m, color=:orange, showfacets=true, facetcolor=:cyan)
    @test_reference joinpath(datadir, "surf3D-6.png") viz(m, color=:orange, alpha=0.5)
    @test_reference joinpath(datadir, "surf3D-7.png") viz(m, color=1:ne, alpha=0.5)
    @test_reference joinpath(datadir, "surf3D-8.png") viz(m, color=1:ne, alpha=range(0.1, 1.0, length=ne))

    # volume meshes
    g = CartesianGrid(10, 10, 10)
    v = vertices(g)
    e = collect(elements(topology(g)))
    m = SimpleMesh(v, e)
    nv = nvertices(m)
    ne = nelements(m)
    @test_reference joinpath(datadir, "vol3D-1.png") viz(m)
    @test_reference joinpath(datadir, "vol3D-2.png") viz(m, color=1:nv)
    @test_reference joinpath(datadir, "vol3D-3.png") viz(m, color=1:ne)
    @test_reference joinpath(datadir, "vol3D-4.png") viz(m, color=:orange)
    @test_reference joinpath(datadir, "vol3D-5.png") viz(m, color=:orange, alpha=0.5)
    @test_reference joinpath(datadir, "vol3D-6.png") viz(m, color=1:ne, alpha=0.5)
    @test_reference joinpath(datadir, "vol3D-7.png") viz(m, color=1:ne, alpha=range(0.1, 1.0, length=ne))

    # vector of points
    p = Point2[(0.0, 0.0), (1.0, 0.0), (1.0, 1.0), (0.0, 1.0)]
    @test_reference joinpath(datadir, "points2D-1.png") viz(p)
    @test_reference joinpath(datadir, "points2D-2.png") viz(p, color=1:4)
    @test_reference joinpath(datadir, "points2D-3.png") viz(p, color=1:4, colorscheme=:inferno)
    @test_reference joinpath(datadir, "points2D-4.png") viz(p, pointsize=20)
    @test_reference joinpath(datadir, "points2D-5.png") viz(p, color=:red)
    @test_reference joinpath(datadir, "points2D-6.png") viz(p, color=:red, alpha=0.5)
    @test_reference joinpath(datadir, "points2D-7.png") viz(p, color=1:4, alpha=0.5)

    # vector of 2D geometries
    t = Triangle((1.0, 0.0), (2.0, 0.0), (2.0, 1.0))
    q = Quadrangle((0.0, 0.0), (1.0, 0.0), (1.0, 1.0), (0.0, 1.0))
    g = [t, q]
    @test_reference joinpath(datadir, "geoms2D-1.png") viz(g)
    @test_reference joinpath(datadir, "geoms2D-2.png") viz(g, color=1:2)
    @test_reference joinpath(datadir, "geoms2D-3.png") viz(g, color=1:2, colorscheme=:inferno)
    @test_reference joinpath(datadir, "geoms2D-4.png") viz(g, color=:red)
    @test_reference joinpath(datadir, "geoms2D-5.png") viz(g, color=:red, alpha=0.5)
    @test_reference joinpath(datadir, "geoms2D-6.png") viz(g, color=1:2, alpha=0.5)
    @test_reference joinpath(datadir, "geoms2D-7.png") viz(g, showfacets=true, facetcolor=:red)

    # vector of 3D geometries
    c1 = Cylinder((0.0, 0.0, 0.0), (1.0, 1.0, 0.0), 2.0)
    c2 = Cylinder((2.0, 2.0, 0.0), (3.0, 3.0, 0.0), 1.0)
    g = [c1, c2]
    @test_reference joinpath(datadir, "geoms3D-1.png") viz(g)
    @test_reference joinpath(datadir, "geoms3D-2.png") viz(g, color=1:2)
    @test_reference joinpath(datadir, "geoms3D-3.png") viz(g, color=1:2, colorscheme=:inferno)
    @test_reference joinpath(datadir, "geoms3D-4.png") viz(g, color=:red)
    @test_reference joinpath(datadir, "geoms3D-5.png") viz(g, color=:red, alpha=0.5)
    @test_reference joinpath(datadir, "geoms3D-6.png") viz(g, color=1:2, alpha=0.5)

    # vector of 1D, 2D, 3D geometries
    p = Point(2, 2, 0)
    t = Triangle((1, 0, 2), (1, 1, 2), (0, 1, 2))
    h = first(CartesianGrid(1, 1, 1))
    g = [p, t, h]
    @test_reference joinpath(datadir, "geoms-1.png") viz(g)
    @test_reference joinpath(datadir, "geoms-2.png") viz(g, color=1:3)
    @test_reference joinpath(datadir, "geoms-3.png") viz(g, color=1:3, colorscheme=:inferno)
    @test_reference joinpath(datadir, "geoms-4.png") viz(g, color=:red)
    @test_reference joinpath(datadir, "geoms-5.png") viz(g, color=:red, alpha=0.5)
    @test_reference joinpath(datadir, "geoms-6.png") viz(g, color=1:3, alpha=0.5)

    # views of grids (optimized for performance)
    g = CartesianGrid(10, 10)
    v = view(g, 1:2:100)
    @test_reference joinpath(datadir, "gridview2D-1.png") viz(v)
    @test_reference joinpath(datadir, "gridview2D-2.png") viz(v, color=1:50)
    @test_reference joinpath(datadir, "gridview2D-3.png") viz(v, color=1:50, colorscheme=:inferno)
    g = CartesianGrid(10, 10, 10)
    v = view(g, 1:2:1000)
    @test_reference joinpath(datadir, "gridview3D-1.png") viz(v)
    @test_reference joinpath(datadir, "gridview3D-2.png") viz(v, color=1:500)
    @test_reference joinpath(datadir, "gridview3D-3.png") viz(v, color=1:500, colorscheme=:inferno)

    # views of meshes
    g = CartesianGrid(10, 10)
    m = convert(SimpleMesh, g)
    v = view(m, 1:2:100)
    @test_reference joinpath(datadir, "meshview2D-1.png") viz(v)
    @test_reference joinpath(datadir, "meshview2D-2.png") viz(v, color=1:50)
    @test_reference joinpath(datadir, "meshview2D-3.png") viz(v, color=1:50, colorscheme=:inferno)
    g = CartesianGrid(10, 10, 10)
    m = convert(SimpleMesh, g)
    v = view(m, 1:2:1000)
    @test_reference joinpath(datadir, "meshview3D-1.png") viz(v)
    @test_reference joinpath(datadir, "meshview3D-2.png") viz(v, color=1:500)
    @test_reference joinpath(datadir, "meshview3D-3.png") viz(v, color=1:500, colorscheme=:inferno)

    # reactilinear grid
    x = 0:0.2:1
    y = [0.0, 0.1, 0.3, 0.7, 0.9, 1.0]
    g = RectilinearGrid(x, y)
    @test_reference joinpath(datadir, "reactilineargrid2D-1.png") viz(g, showfacets=true)
    @test_reference joinpath(datadir, "reactilineargrid2D-2.png") viz(g, showfacets=true, facetcolor=:red)
    @test_reference joinpath(datadir, "reactilineargrid2D-3.png") viz(g, color=1:25, colorscheme=:inferno)
    @test_reference joinpath(datadir, "reactilineargrid2D-4.png") viz(g, color=:red, alpha=0.5, showfacets=true)
    @test_reference joinpath(datadir, "reactilineargrid2D-5.png") viz(g, color=1:25, showfacets=true, facetcolor=:red)
    @test_reference joinpath(datadir, "reactilineargrid2D-6.png") viz(
      g,
      showfacets=true,
      facetcolor=:red,
      segmentsize=5
    )

    # structured grid
    X = [i / 20 * cos(3π / 2 * (j - 1) / (30 - 1)) for i in 1:20, j in 1:30]
    Y = [i / 20 * sin(3π / 2 * (j - 1) / (30 - 1)) for i in 1:20, j in 1:30]
    g = StructuredGrid(X, Y)
    @test_reference joinpath(datadir, "structuredgrid2D-1.png") viz(g, showfacets=true)
    @test_reference joinpath(datadir, "structuredgrid2D-2.png") viz(g, showfacets=true, facetcolor=:red)
    @test_reference joinpath(datadir, "structuredgrid2D-3.png") viz(g, color=1:551, colorscheme=:inferno)
    @test_reference joinpath(datadir, "structuredgrid2D-4.png") viz(g, color=:red, alpha=0.5, showfacets=true)
    @test_reference joinpath(datadir, "structuredgrid2D-5.png") viz(g, color=1:551, showfacets=true, facetcolor=:red)
    @test_reference joinpath(datadir, "structuredgrid2D-6.png") viz(g, showfacets=true, facetcolor=:red, segmentsize=5)

    # missing values
    rng = MersenneTwister(123)
    d = CartesianGrid(2, 2)
    c = [1, missing, 3, missing]
    @test_reference joinpath(datadir, "missing-1.png") viz(d, color=c)
    d = CartesianGrid(2, 2)
    c = [1.0, NaN, 3.0, NaN]
    @test_reference joinpath(datadir, "missing-2.png") viz(d, color=c)
  end

  @testset "viewer" begin
    grid = CartesianGrid(10, 10)

    # continuous variables
    a = rand(rng, 100)
    gtb = georef((; a), grid)
    @test_reference joinpath(datadir, "viewer-continuous.png") viewer(gtb)

    # categorical variables
    a = rand(rng, 1:5, 100)
    gtb = georef((; a), grid)
    @test_reference joinpath(datadir, "viewer-categorical-1.png") viewer(gtb)
    a = rand(rng, ["yes", "no"], 100)
    gtb = georef((; a), grid)
    @test_reference joinpath(datadir, "viewer-categorical-2.png") viewer(gtb)

    # distributional variables
    a = Normal.(rand(rng, 100), rand(rng, 100))
    gtb = georef((; a), grid)
    @test_reference joinpath(datadir, "viewer-distributional.png") viewer(gtb)

    # colors
    a = Gray.(rand(rng, 100))
    gtb = georef((; a), grid)
    @test_reference joinpath(datadir, "viewer-colors.png") viewer(gtb)

    # constant columns
    # continuous
    a = fill(1.0, 100)
    gtb = georef((; a), grid)
    @test_reference joinpath(datadir, "viewer-const-continuous.png") viewer(gtb)
    # categorical
    a = fill("test", 100)
    gtb = georef((; a), grid)
    @test_reference joinpath(datadir, "viewer-const-categorical.png") viewer(gtb)
    # distributional
    a = fill(Normal(), 100)
    gtb = georef((; a), grid)
    @test_reference joinpath(datadir, "viewer-const-distributional.png") viewer(gtb)
    # color
    a = fill(Gray(0.1), 100)
    gtb = georef((; a), grid)
    @test_reference joinpath(datadir, "viewer-const-color.png") viewer(gtb)

    # missing values
    missings = fill(missing, 20)
    # continuous with missing
    a = shuffle(rng, [missings; rand(rng, 80)])
    gtb = georef((; a), grid)
    @test_reference joinpath(datadir, "viewer-missing-continuous-1.png") viewer(gtb)
    # continuous with NaN
    a = shuffle(rng, [fill(NaN, 20); rand(rng, 80)])
    gtb = georef((; a), grid)
    @test_reference joinpath(datadir, "viewer-missing-continuous-2.png") viewer(gtb)
    # continuous with missing and NaN
    a = shuffle(rng, [fill(missing, 10); fill(NaN, 10); rand(rng, 80)])
    gtb = georef((; a), grid)
    @test_reference joinpath(datadir, "viewer-missing-continuous-3.png") viewer(gtb)
    # categorical
    a = shuffle(rng, [missings; rand(rng, 'a':'e', 80)])
    gtb = georef((; a), grid)
    @test_reference joinpath(datadir, "viewer-missing-categorical.png") viewer(gtb)
    # distributional
    a = shuffle(rng, [missings; Normal.(rand(rng, 80), rand(rng, 80))])
    gtb = georef((; a), grid)
    @test_reference joinpath(datadir, "viewer-missing-distributional.png") viewer(gtb)
    # colors
    a = shuffle(rng, [missings; RGB.(rand(rng, 80), rand(rng, 80), rand(rng, 80))])
    gtb = georef((; a), grid)
    @test_reference joinpath(datadir, "viewer-missing-colors.png") viewer(gtb)

    # units
    # continuous
    a = rand(rng, 100) * u"m/s"
    gtb = georef((; a), grid)
    @test_reference joinpath(datadir, "viewer-unit-continuous.png") viewer(gtb)
    # categorical
    a = rand(rng, 1:5, 100) * u"°C"
    gtb = georef((; a), grid)
    @test_reference joinpath(datadir, "viewer-unit-categorical.png") viewer(gtb)
    # continuous with missing
    a = shuffle(rng, [missings; rand(rng, 80)]) * u"m/s"
    gtb = georef((; a), grid)
    @test_reference joinpath(datadir, "viewer-unit-missing-continuous.png") viewer(gtb)
    # categorical with missing
    a = shuffle(rng, [missings; rand(rng, 1:5, 80)]) * u"°C"
    gtb = georef((; a), grid)
    @test_reference joinpath(datadir, "viewer-unit-missing-categorical.png") viewer(gtb)

    # error: could not find viewable variables
    a = fill(missing, 100) # all missing values
    b = fill(NaN, 100) # all missing values
    c = fill(nothing, 100) # Unknown scitype
    gtb = georef((; a, b, c), grid)
    @test_throws AssertionError viewer(gtb)
  end
end
