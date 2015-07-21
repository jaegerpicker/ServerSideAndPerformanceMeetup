(use '[clojure.string :only (split)])
(use '[clojure.contrib.seq :only (positions)])

; Sample code to read in test cases:
; Open the file passed as the first command line argument
(with-open [rdr (clojure.java.io/reader (first *command-line-args*))]
  ; Read each line ignoring empty ones
  (doseq [line (remove empty? (line-seq rdr))]
    (parseLine line)))
; First in the function cascade
; Parses a line of the game board
(defn parseLine
  [line]
  (let direction (get_direction line))
  (let grid_size (get_grid_size line))
  (println (do_move direction grid_size line 0)))

; Get the direction of the game move
(defn get_direction
  [line]
  (nth (split line #";") 1)
  )

; Get the size of the grid
(defn get_grid_size
  [line]
  (nth (split line #";") 2))


; Starts the move
(defn do_move
  [direction grid_size line movement]
  (let grid_lines (nth (split line #";") 3))
  (let grid (split line #"|"))
  (for [i (range grid_size)] (get_line grid direction (movement * i)))
  )

; Grab the line to process
(defn get_line
  [grid_lines direction line_no]
  (if (= direction "RIGHT")
    (ret_line (nth grid_lines line_no)))
  (if (= direction "LEFT")
    ; Gah this is ugly and if I didn't suck at clojure I'd know a better way
    (reverse (ret_line (reverse (nth grid_lines line_no)))))
  (if (= direction "DOWN")
    (ret_line (get_column grid_lines line_no)))
  (if (= direction "UP")
     (reverse (ret_line (reverse (get_column grid_lines line_no)))))
  )


; Grab indiviual columns to work on
(defn get_column
  [grid_lines line_no]
  (map #(nth % line_no) grid_lines)
  )

(defn ret_line
  [line]
  (let vals (split line #""))
  (let ret (vector))
  (let non_zero_vals (dissoc-idx vals (positions #{0} vals)))
  (for [i (range (count non_zero_vals))] (combine_indexes non_zero_vals i (+ i 1)))
  )

; Basic Utilities functions below here



; Filter out certain the passed in index passed in
; used to skip zero's
(defn index-exclude
  [r ex]
  (filter #(not (ex %)) (range r)))

; dissociate indexes of nonzero values
(defn dissoc-idx
  [v & ds]
  (map v (index-exclude (count v) (into #{} ds))))

; So this crazy thing is poorly named but basically it returns a 0, the static value
; or the Combined values, basically aggegrating all the info together
(defn combine_indexes
  [line current_index next_index]

  (if (= (nth line current_index) (nth line next_index)
        (+ (nth line current_index) (nth line next_index))
        (if (= (count line) (+ next_index 1)) combine_indexes line current (+ next_index 1)) 0))
  )
