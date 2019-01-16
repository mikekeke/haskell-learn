newtype PrsEP a = PrsEP { runPrsEP :: Int -> String -> (Int, Either String (a, String)) }

parseEP :: PrsEP a -> String -> Either String (a, String)
parseEP p  = snd . runPrsEP p 0

-- my initial
-- satisfyEP p = PrsEP f where
--     f i s | null s = (next, Left $ "pos " ++ show next ++ ": unexpected end of input")
--           | p c = (next, Right (c, cs))
--           | otherwise = (next, Left $ "pos " ++ show next ++ ": unexpected " ++ [c])
--            where 
--             next = succ i
--             (c:cs) = s

-- better (?) after reading solutions
satisfyEP p = PrsEP (f . succ) where
    f i s | null s = (i, Left $ "pos " ++ show i ++ ": unexpected end of input")
          | p c = (i, Right (c, cs))
          | otherwise = (i, Left $ "pos " ++ show i ++ ": unexpected " ++ [c])
           where (c:cs) = s

charEP :: Char -> PrsEP Char
charEP c = satisfyEP (== c)

{-
best from solutions
satisfyEP :: (Char -> Bool) -> PrsEP Char
satisfyEP pr = PrsEP (f . succ) where
    f pos []                 = (pos, Left ("pos " ++ show pos ++ ": unexpected end of input"))
    f pos (c:cs) | pr c      = (pos, Right (c, cs))
                 | otherwise = (pos, Left ("pos " ++ show pos ++ ": unexpected " ++ [c]))
-}