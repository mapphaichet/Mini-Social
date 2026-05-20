import numpy as np
import sqlite3
from collections import defaultdict
from underthesea import word_tokenize

class NaiveBayesClassifier:
    def __init__(self, db_name="../database.db"):
        self.class_priors = {}
        self.word_probs = {}
        self.vocab = set()
        self.db_name = db_name

        # Tạo bảng nếu chưa có
        conn = sqlite3.connect(self.db_name)
        cursor = conn.cursor()

        # Bảng lưu xác suất từ theo lớp
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS word_probs (
                text TEXT PRIMARY KEY,
                pos_per REAL,
                neg_per REAL
            )
        """)

        # Bảng lưu class priors
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS class_priors (
                class TEXT PRIMARY KEY,
                prior REAL
            )
        """)

        conn.commit()
        conn.close()

    def fit(self, X, y):
        n_samples = len(X)
        classes = np.unique(y)

        # Tính xác suất tiên nghiệm P(y)
        for c in classes:
            self.class_priors[c] = np.sum(y == c) / n_samples

        # Đếm từ theo lớp
        print("counting words...")
        word_counts = {c: defaultdict(int) for c in classes}
        class_word_totals = {c: 0 for c in classes}

        for text, label in zip(X, y):
            words = text.split()
            for w in words:
                word_counts[label][w] += 1
                class_word_totals[label] += 1
                self.vocab.add(w)

        # Tính xác suất có điều kiện P(word|class) với Laplace smoothing
        print("training model...")
        for c in classes:
            self.word_probs[c] = {}
            total = class_word_totals[c] + len(self.vocab)
            for w in self.vocab:
                self.word_probs[c][w] = (word_counts[c][w] + 1) / total

        # Lưu vào database
        conn = sqlite3.connect(self.db_name)
        cursor = conn.cursor()

        # Xóa dữ liệu cũ
        cursor.execute("DELETE FROM word_probs")
        cursor.execute("DELETE FROM class_priors")

        # Lưu word_probs (không round, lưu nguyên giá trị float)
        for w in self.vocab:
            pos_per = self.word_probs.get("POS", {}).get(w, 0.0)
            neg_per = self.word_probs.get("NEG", {}).get(w, 0.0)
            cursor.execute("""
                INSERT INTO word_probs (text, pos_per, neg_per)
                VALUES (?, ?, ?)
            """, (w, pos_per, neg_per))

        # Lưu class_priors (không round)
        for c in self.class_priors:
            cursor.execute("""
                INSERT INTO class_priors (class, prior)
                VALUES (?, ?)
            """, (c, self.class_priors[c]))

        conn.commit()
        conn.close()

        print("Đã huấn luyện và lưu tham số vào database.")

    def load(self):
        conn = sqlite3.connect(self.db_name)
        cursor = conn.cursor()

        # Load word_probs
        cursor.execute("SELECT text, pos_per, neg_per FROM word_probs")
        rows = cursor.fetchall()
        self.word_probs["POS"] = {}
        self.word_probs["NEG"] = {}
        self.vocab = set()
        for text, pos_per, neg_per in rows:
            self.word_probs["POS"][text] = pos_per
            self.word_probs["NEG"][text] = neg_per
            self.vocab.add(text)

        # Load class_priors
        cursor.execute("SELECT class, prior FROM class_priors")
        rows = cursor.fetchall()
        self.class_priors = {c: prior for c, prior in rows}

        conn.close()
        print("Đã load tham số từ database.")

    def predict(self, X):
        X = [NaiveBayesClassifier.lower_case(text) for text in X]
        X = [NaiveBayesClassifier.viet_word_segmentation(text) for text in X]
        preds = []
        all_class_scores = []
        for text in X:
            words = text.split()
            class_scores = {}
            for c in self.class_priors:
                score = np.log(self.class_priors[c])
                for w in words:
                    if w in self.vocab:
                        if(self.word_probs[c][w] == 0): 
                            print("Word not found:", w, self.word_probs[c][w])
                            continue
                        try:
                            score += np.log(self.word_probs[c][w])
                        except KeyError:
                            print("Word not found:", w)
                            pass
                class_scores[c] = score
            preds.append(max(class_scores, key=class_scores.get))
            all_class_scores.append(class_scores)
        return preds, all_class_scores

    def lower_case(text):
        return text.lower()  

    def viet_word_segmentation(text):
        """
        Hàm ghép từ tiếng Việt (Word Segmentation)
        Input: chuỗi văn bản tiếng Việt
        Output: chuỗi với các từ ghép nối bằng dấu gạch dưới
        """
        tokens = word_tokenize(text, format="text")
        return tokens
