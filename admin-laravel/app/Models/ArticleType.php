<?php

namespace App\Models;

use Encore\Admin\Traits\DefaultDatetimeFormat;
use Encore\Admin\Traits\ModelTree;
use Illuminate\Database\Eloquent\Model;

class ArticleType extends Model
{
    use DefaultDatetimeFormat;
    use ModelTree;
    
    protected $table = 'article_types';

    public function getList(){
        return $this->get();
    }
}
