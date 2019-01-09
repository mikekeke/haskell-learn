newtype PrsE a = PrsE { runPrsE :: String -> Either String (a, String) }

instance Functor PrsE where
    fmap f = PrsE . (fmap . fmap $ \(a, s) -> (f a, s)) . runPrsE
    
instance Applicative PrsE where
    pure x = PrsE $ \s -> Right (x, s)
    pf <*> px = PrsE $ \s -> case runPrsE pf s of
                                Left e        -> Left e
                                Right (f, s') -> runPrsE (f <$> px) s'

instance Monad PrsE where
    m >>= k = PrsE $ \s -> case runPrsE m s of
            Left e        -> Left e
            Right (v, s') -> runPrsE (k v) s'

{- from answers

instance Monad PrsE where
  return x = PrsE $ \s-> Right (x, s)
  (PrsE pa) >>= f = PrsE $ \s -> do
    (x , s') <- pa s
    runPrsE (f x) s'

instance Monad PrsE where
  (>>=) (PrsE v) k = PrsE $ \s -> (v s) >>= uncurry (runPrsE . k)

-}