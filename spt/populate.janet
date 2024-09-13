(import spt/trace/generate :as tg)

(def samples-path
  (string (dyn :syspath) "/spt/trace/samples"))

(each filepath (os/dir samples-path)
  (print "* " filepath)
  (def full-path (string samples-path "/" filepath))
  (def not-including-extension
    (last (string/find-all "." full-path)))
  (def last-slash
    (last (string/find-all "/" full-path)))
  (def dir-path 
    (string/slice full-path 
                  (inc last-slash) not-including-extension))
  (def old-dir (os/cwd))
  #
  (defer (os/cd old-dir)
    # remove any old stuff
    (when (and (os/stat dir-path)
               (= :directory (os/stat dir-path :mode)))
      (defer (os/cd old-dir)
        (os/cd dir-path)
        (each item (os/dir ".")
          (os/rm item)))
      (os/rmdir dir-path))
    # produce new stuff
    (tg/gen-files (slurp full-path) false dir-path false)))

(print)
(print "Note that at least one bit of error output is normal as it is")
(print "a side-effect of meg/match processing.")
