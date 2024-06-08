<?php

namespace App\Models;

use Encore\Admin\Traits\DefaultDatetimeFormat;
use Illuminate\Database\Eloquent\Model;

class Article extends Model
{
    use DefaultDatetimeFormat;

    protected $table = 'articles';

    public function articleType()
    {
        return $this->hasOne(ArticleType::class, 'id', 'type_id');
    }

    public static function getRecommended()
    {
        return self::where('is_recommend', 1)->orderBy('id', 'DESC')->limit(3)->get();
    }

    public static function getUnRecommended()
    {
        return self::where('is_recommend', 0)->orderBy('id', 'DESC')->limit(3)->get();
    }

    public static function getWelcomeInfo()
    {
        return self::where('type_id',1)->orderBy('id', 'DESC')->limit(3)->get();
    }

    public static function getRecent()
    {
        return self::orderBy('id', 'DESC')->limit(5)->get();
    }

    public static function getAllArticles()
    {
        return self::orderBy('id', 'DESC')->get();
    }
}
