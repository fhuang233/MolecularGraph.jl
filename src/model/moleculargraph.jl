#
# This file is a part of graphmol.jl
# Licensed under the MIT License http://opensource.org/licenses/MIT
#

export
    MolecularGraph,
    getatom,
    getbond,
    newatom!,
    updatebond!,
    required_descriptor


mutable struct MolecularGraph
    graph::UndirectedGraph
    descriptors::Set
end

MolecularGraph() = MolecularGraph(UndirectedGraph{UInt16}(), Set())


function getatom(mol::MolecularGraph, idx)
    getnode(mol.graph, idx)
end


function getbond(mol::MolecularGraph, u, v)
    getedge(mol.graph, u, v)
end


function newatom!(mol::MolecularGraph, atom::Atom)
    newnode!(mol.graph, atom)
end

function newatom!(mol::MolecularGraph, idx::Integer, atom::Atom)
    atom.index = idx
    newatom!(mol, atom)
end


function updatebond!(mol::MolecularGraph, bond::Bond)
    updateedge!(mol.graph, bond)
end

function updatebond!(mol::MolecularGraph, u::Integer, v::Integer, bond::Bond)
    bond.u = u
    bond.v = v
    updatebond!(mol, bond)
end


function required_descriptor(mol::MolecularGraph, desc::AbstractString)
    if desc ∉ mol.descriptors
        throw(ErrorException("$(desc) is not assigned"))
    end
end
