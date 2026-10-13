let compose f g = fun x -> f (g x);;
\\ Cette fonction est de type : ( a ->b ) -> c -> a -> b
\\ Correction ( a -> b) -> (c -> a ) -> c -> b 