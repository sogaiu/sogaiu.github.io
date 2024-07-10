(def patterns
  ["accumulate"
   "backmatch"
   "backref"
   "cmt"
   "group"
   "lenprefix"
   "sequence"
   "split"
   "sub"
   "unref"])

(each patt patterns
  (def old-dir (os/cwd))
  (defer (os/cd old-dir)
    # remove any old stuff
    (when (and (os/stat patt)
               (= :directory (os/stat patt :mode)))
      (defer (os/cd old-dir)
        (os/cd patt)
        (each item (os/dir ".")
          (os/rm item)))
      (os/rmdir patt))
    # produce new stuff
    (os/execute ["pdoc" "-t" patt] :px)
    (os/rename "meg-trace" patt)))
