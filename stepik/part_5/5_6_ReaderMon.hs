-- localTest :: Reader [Int] (Int,Int,Int)
import Control.Monad.Reader

fromStr2 :: String -> Int
fromStr2 s = read s
fromStr2' :: String ->  Int
fromStr2' s = (read s) + 30
calc2 :: String -> (Int, Int)
calc2 = do
    x1 <- fromStr2
    x2 <- fromStr2'
    return (x1, x2)

localTest :: [Integer] -> (Int, Int, Int)
localTest = do 
    c1 <- length
    c2 <- local (1:) length
    c3 <- length
    return (c1,c2,c3)


toMaybeJ :: Int -> String -> Maybe String
toMaybeJ x e = Just $ e++" "++show (x+1)
toMaybeN :: Int -> String -> Maybe String
toMaybeN _ _ = Nothing
doReaderT :: Int -> ReaderT String Maybe String
doReaderT x = do 
    e <- ask
    s1 <- lift $ toMaybeJ x e
    lift $ toMaybeJ (x*2) s1

testRT = runReaderT . doReaderT