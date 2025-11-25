;;; lorem-ipsum-english.el --- Insert English filler text -*- lexical-binding: t -*-

;; Copyright (C) 2025 Raoul Comninos

;; Author: Raoul Comninos
;; Version: 0.1.0
;; Package-Requires: ((emacs "24.3"))
;; Keywords: convenience, text, writing
;; URL: https://github.com/yourusername/lorem-ipsum-english
;; SPDX-License-Identifier: MIT

;; Permission is hereby granted, free of charge, to any person obtaining a copy
;; of this software and associated documentation files (the "Software"), to deal
;; in the Software without restriction, including without limitation the rights
;; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
;; copies of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:
;;
;; The above copyright notice and this permission notice shall be included in all
;; copies or substantial portions of the Software.
;;
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.

;;; Commentary:

;; This package provides commands to insert English filler text from
;; classic public domain poetry and literature.  It works similarly to
;; the lorem-ipsum package but uses beautiful English sentences instead
;; of Latin text.
;;
;; Usage:
;;
;;   M-x lorem-ipsum-english-insert-sentences RET
;;   M-x lorem-ipsum-english-insert-paragraphs RET
;;   M-x lorem-ipsum-english-insert-list RET
;;
;; You can also use a numeric prefix argument to specify how many
;; items to insert:
;;
;;   C-u 5 M-x lorem-ipsum-english-insert-sentences RET
;;
;; Configure default keybindings with:
;;
;;   (lorem-ipsum-english-use-default-bindings)

;;; Code:

(defconst lorem-ipsum-english-text
  '(("Shall I compare thee to a summer's day?"
     "Thou art more lovely and more temperate."
     "Rough winds do shake the darling buds of May."
     "And summer's lease hath all too short a date.")
    ("I wandered lonely as a cloud that floats on high o'er vales and hills."
     "When all at once I saw a crowd, a host of golden daffodils."
     "Beside the lake, beneath the trees, fluttering and dancing in the breeze.")
    ("Season of mists and mellow fruitfulness, close bosom-friend of the maturing sun."
     "Conspiring with him how to load and bless with fruit the vines that round the thatch-eaves run.")
    ("It was the best of times, it was the worst of times."
     "It was the age of wisdom, it was the age of foolishness."
     "It was the epoch of belief, it was the epoch of incredulity."
     "It was the season of Light, it was the season of Darkness.")
    ("The woods are lovely, dark and deep."
     "But I have promises to keep, and miles to go before I sleep."
     "And miles to go before I sleep.")
    ("To be, or not to be, that is the question."
     "Whether 'tis nobler in the mind to suffer the slings and arrows of outrageous fortune."
     "Or to take arms against a sea of troubles and by opposing end them.")
    ("All that we see or seem is but a dream within a dream."
     "Is all that we see or seem but a dream within a dream?"
     "I stand amid the roar of a surf-tormented shore.")
    ("Hope is the thing with feathers that perches in the soul."
     "And sings the tune without the words, and never stops at all."
     "And sweetest in the gale is heard, and sore must be the storm.")
    ("Two roads diverged in a yellow wood, and sorry I could not travel both."
     "And be one traveler, long I stood and looked down one as far as I could."
     "To where it bent in the undergrowth.")
    ("The sun does arise, and make happy the skies."
     "The merry bells ring to welcome the Spring."
     "The skylark and thrush, the birds of the bush, sing louder around to the bells' cheerful sound.")
    ("A thing of beauty is a joy forever."
     "Its loveliness increases; it will never pass into nothingness."
     "But still will keep a bower quiet for us, and a sleep full of sweet dreams.")
    ("How do I love thee? Let me count the ways."
     "I love thee to the depth and breadth and height my soul can reach."
     "I love thee freely, as men strive for Right.")
    ("Once upon a midnight dreary, while I pondered, weak and weary."
     "Over many a quaint and curious volume of forgotten lore."
     "While I nodded, nearly napping, suddenly there came a tapping.")
    ("I hear America singing, the varied carols I hear."
     "Those of mechanics, each one singing his as it should be blithe and strong."
     "The carpenter singing his as he measures his plank or beam.")
    ("The apparition of these faces in the crowd."
     "Petals on a wet, black bough."
     "In a station of the metro.")
    ("If you can keep your head when all about you are losing theirs and blaming it on you."
     "If you can trust yourself when all men doubt you, but make allowance for their doubting too."
     "If you can wait and not be tired by waiting, or being lied about, don't deal in lies.")
    ("Do not go gentle into that good night."
     "Old age should burn and rave at close of day."
     "Rage, rage against the dying of the light."))
  "English text from classic poetry and literature.")

(defgroup lorem-ipsum-english nil
  "Insert English filler text from classic literature."
  :group 'convenience
  :prefix "lorem-ipsum-english-")

(defcustom lorem-ipsum-english-sentence-separator " "
  "Separator to use between sentences."
  :type 'string
  :group 'lorem-ipsum-english)

(defcustom lorem-ipsum-english-paragraph-separator "\n\n"
  "Separator to use between paragraphs."
  :type 'string
  :group 'lorem-ipsum-english)

(defcustom lorem-ipsum-english-list-beginning "* "
  "String to prepend to each list item."
  :type 'string
  :group 'lorem-ipsum-english)

(defcustom lorem-ipsum-english-list-ending "\n"
  "String to append to each list item."
  :type 'string
  :group 'lorem-ipsum-english)

(defvar lorem-ipsum-english-map nil
  "Keymap for lorem-ipsum-english commands.")

(defun lorem-ipsum-english--random-sentence ()
  "Return a random sentence from the English text corpus."
  (let* ((random-group (seq-random-elt lorem-ipsum-english-text))
         (random-sentence (seq-random-elt random-group)))
    random-sentence))

(defun lorem-ipsum-english--sentences (count)
  "Generate COUNT random sentences."
  (let ((sentences '()))
    (dotimes (_ count)
      (push (lorem-ipsum-english--random-sentence) sentences))
    (nreverse sentences)))

;;;###autoload
(defun lorem-ipsum-english-insert-sentences (&optional count)
  "Insert COUNT English sentences at point.
If COUNT is not specified, insert one sentence.  Prefix arg
specifies how many sentences to insert."
  (interactive "p")
  (let ((count (or count 1)))
    (when (< count 1)
      (user-error "Count must be at least 1"))
    (insert (mapconcat #'identity
                       (lorem-ipsum-english--sentences count)
                       lorem-ipsum-english-sentence-separator))))

;;;###autoload
(defun lorem-ipsum-english-insert-paragraphs (&optional count)
  "Insert COUNT English paragraphs at point.
If COUNT is not specified, insert one paragraph.  Prefix arg
specifies how many paragraphs to insert.  Each paragraph contains
3-6 random sentences."
  (interactive "p")
  (let ((count (or count 1)))
    (when (< count 1)
      (user-error "Count must be at least 1"))
    (dotimes (i count)
      (let ((sentences-per-para (+ 3 (random 4))))
        (lorem-ipsum-english-insert-sentences sentences-per-para))
      (when (< i (1- count))
        (insert lorem-ipsum-english-paragraph-separator)))))

;;;###autoload
(defun lorem-ipsum-english-insert-list (&optional count)
  "Insert COUNT English list items at point.
If COUNT is not specified, insert one item.  Prefix arg specifies
how many items to insert."
  (interactive "p")
  (let ((count (or count 1)))
    (when (< count 1)
      (user-error "Count must be at least 1"))
    (dotimes (_ count)
      (insert lorem-ipsum-english-list-beginning)
      (lorem-ipsum-english-insert-sentences 1)
      (insert lorem-ipsum-english-list-ending))))

;;;###autoload
(defun lorem-ipsum-english-use-default-bindings ()
  "Bind English Lorem Ipsum commands to keybindings.
Sets up global keybindings under the prefix for convenience."
  (interactive)
  (unless lorem-ipsum-english-map
    (setq lorem-ipsum-english-map (make-sparse-keymap))
    (define-key lorem-ipsum-english-map (kbd "s") #'lorem-ipsum-english-insert-sentences)
    (define-key lorem-ipsum-english-map (kbd "p") #'lorem-ipsum-english-insert-paragraphs)
    (define-key lorem-ipsum-english-map (kbd "l") #'lorem-ipsum-english-insert-list))
  (global-set-key (kbd "C-c l") lorem-ipsum-english-map))

;; Adapt list formatting for HTML/SGML modes
(add-hook 'sgml-mode-hook
          (lambda ()
            (setq-local lorem-ipsum-english-list-beginning "<li>")
            (setq-local lorem-ipsum-english-list-ending "</li>\n")))

(provide 'lorem-ipsum-english)
;;; lorem-ipsum-english.el ends here
