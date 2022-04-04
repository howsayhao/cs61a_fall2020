test = {
  'name': 'Problem 4',
  'points': 1,
  'suites': [
    {
      'cases': [
        {
          'code': r"""
          >>> env = create_global_frame()
          >>> twos = Pair(2, Pair(2, nil))
          >>> plus = PrimitiveProcedure(scheme_add) # + procedure
          >>> scheme_apply(plus, twos, env) # Type SchemeError if you think this errors
          46beb7deeeb5e9af1c8d785b12558317
          # locked
          """,
          'hidden': False,
          'locked': True,
          'multiline': False
        },
        {
          'code': r"""
          >>> env = create_global_frame()
          >>> twos = Pair(2, Pair(2, nil))
          >>> oddp = PrimitiveProcedure(scheme_oddp) # odd? procedure
          >>> scheme_apply(oddp, twos, env) # Type SchemeError if you think this errors
          ec908af60f03727428c7ee3f22ec3cd8
          # locked
          """,
          'hidden': False,
          'locked': True,
          'multiline': False
        },
        {
          'code': r"""
          >>> env = create_global_frame()
          >>> two = Pair(2, nil)
          >>> eval = PrimitiveProcedure(scheme_eval, True) # eval procedure
          >>> scheme_apply(eval, two, env) # be sure to check use_env
          2
          """,
          'hidden': False,
          'locked': False,
          'multiline': False
        },
        {
          'code': r"""
          >>> env = create_global_frame()
          >>> args = nil
          >>> def make_scheme_counter():
          ...     x = 0
          ...     def scheme_counter():
          ...         nonlocal x
          ...         x += 1
          ...         return x
          ...     return scheme_counter
          >>> counter = PrimitiveProcedure(make_scheme_counter()) # counter
          >>> scheme_apply(counter, args, env) # only call procedure.fn once!
          1
          """,
          'hidden': False,
          'locked': False,
          'multiline': False
        }
      ],
      'scored': True,
      'setup': r"""
      >>> from scheme import *
      """,
      'teardown': '',
      'type': 'doctest'
    }
  ]
}
