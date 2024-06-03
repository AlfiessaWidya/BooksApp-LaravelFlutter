<?php

namespace App\Http\Controllers;

use App\Models\Article;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class ArticlesController extends Controller
{
    public function readAll()
    {
        $articles = Article::all();

        return response()->json([
            'data' => $articles,
        ], 200);
    }
    
    public function welcomeInfo() {
        // Fetch articles using the model method
        $articles = Article::getWelcomeInfo();
        
        // Process articles to strip HTML tags and entities
        foreach ($articles as $article) {
            $article->article_content = strip_tags($article->article_content);
            $article->article_content = preg_replace("/&#?[a-z0-9]+;/i", " ", $article->article_content);
        }

        // Return the processed articles as JSON
        return response()->json($articles);
    }

    public function getRecommended() {
        // Fetch recommended articles using the model method
        $articles = Article::getRecommended();

        foreach ($articles as $article) {
            $article->article_content = strip_tags($article->article_content);
            $article->article_content = preg_replace("/&#?[a-z0-9]+;/i", " ", $article->article_content);
        }

        return response()->json($articles);
    }

    public function allArticles() {
        // Fetch all articles using the model method
        $articles = Article::getAllArticles();

        foreach ($articles as $article) {
            $article->article_content = strip_tags($article->article_content);
            $article->article_content = preg_replace("/&#?[a-z0-9]+;/i", " ", $article->article_content);
        }

        return response()->json($articles);
    }
}
