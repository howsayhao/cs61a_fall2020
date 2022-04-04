""" Optional Questions for Lab 07 """

from lab07 import *

# Q6
def remove_all(link , value):
    """Remove all the nodes containing value. Assume there exists some
    nodes to be removed and the first element is never removed.

    >>> l1 = Link(0, Link(2, Link(2, Link(3, Link(1, Link(2, Link(3)))))))
    >>> print(l1)
    <0 2 2 3 1 2 3>
    >>> remove_all(l1, 2)
    >>> print(l1)
    <0 3 1 3>
    >>> remove_all(l1, 3)
    >>> print(l1)
    <0 1>
    """
    "*** YOUR CODE HERE ***"
    def mutate_remove(link, value):
        while link.rest is not Link.empty:
            if link.rest.first == value:
                link.rest = link.rest.rest
            else:
                link = link.rest
    link = mutate_remove(link,value)

# Q7
def deep_map_mut(fn, link):
    """Mutates a deep link by replacing each item found with the
    result of calling fn on the item.  Does NOT create new Links (so
    no use of Link's constructor)

    Does not return the modified Link object.

    >>> link1 = Link(3, Link(Link(4), Link(5, Link(6))))
    >>> deep_map_mut(lambda x: x * x, link1)
    >>> print(link1)
    <9 <16> 25 36>
    """
    "*** YOUR CODE HERE ***"
    def mutate_map(fn, link):
        linked = link
        while link is not Link.empty:
            if type(link.first) != Link:
                link.first = fn(link.first)
            else:
                link.first = mutate_map(fn, link.first)
            link = link.rest
        return linked
    link = mutate_map(fn, link)

# Q8
def has_cycle(link):
    """Return whether link contains a cycle.

    >>> s = Link(1, Link(2, Link(3)))
    >>> s.rest.rest.rest = s
    >>> has_cycle(s)
    True
    >>> t = Link(1, Link(2, Link(3)))
    >>> has_cycle(t)
    False
    >>> u = Link(2, Link(2, Link(2)))
    >>> has_cycle(u)
    False
    """
    "*** YOUR CODE HERE ***"
    anchor = link
    link = link.rest
    def recursive_cycle(link):
        while link is not Link.empty:
            if link is anchor:
                return True
            link = link.rest
        return False
    return recursive_cycle(link)


def has_cycle_constant(link):
    """Return whether link contains a cycle.

    >>> s = Link(1, Link(2, Link(3)))
    >>> s.rest.rest.rest = s
    >>> has_cycle_constant(s)
    True
    >>> t = Link(1, Link(2, Link(3)))
    >>> has_cycle_constant(t)
    False
    """
    "*** YOUR CODE HERE ***"
    anchor = link
    link = link.rest
    while link is not Link.empty:
        if link is anchor:
            return True
        link = link.rest
    return False

# Q9
def reverse_other(t):
    """Mutates the tree such that nodes on every other (even_indexed) level
    have the labels of their branches all reversed.

    >>> t = Tree(1, [Tree(2), Tree(3), Tree(4)])
    >>> reverse_other(t)
    >>> t
    Tree(1, [Tree(4), Tree(3), Tree(2)])
    >>> t = Tree(1, [Tree(2, [Tree(3, [Tree(4), Tree(5)]), Tree(6, [Tree(7)])]), Tree(8)])
    >>> reverse_other(t)
    >>> t
    Tree(1, [Tree(8, [Tree(3, [Tree(5), Tree(4)]), Tree(6, [Tree(7)])]), Tree(2)])
    """
    "*** YOUR CODE HERE ***"
    level = 1
    def mutate_reverse(t):
        nonlocal level
        level += 1
        if level%2 != 0:
            dex = 0
            for x in t.branches:
                if not x.is_leaf():
                    t.branches[dex] = mutate_reverse(x)
                dex += 1
            return t 
        dex = 0
        j = len(t.branches)
        while j != 0:
            min = t.branches[0].label
            dex = 0
            for x in range(j):
                if t.branches[x].label < min:
                    min = t.branches[x].label
                    dex = x
            j -= 1
            tmp = t.branches[j].label
            t.branches[j].label = t.branches[dex].label
            t.branches[dex].label = tmp
        dex = 0
        for x in t.branches:
            if not x.is_leaf():
                t.branches[dex] = mutate_reverse(x)
            dex += 1
        return t
                
    t = mutate_reverse(t)
