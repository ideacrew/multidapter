module Http
  module Types

    Method              = String.enum(%w(GET POST PUT PATCH DELETE HEAD OPTIONS CONNECT TRACE))
    OperationType       = Coercible::Symbol.default(:request).enum(:request, :response)

  end
end