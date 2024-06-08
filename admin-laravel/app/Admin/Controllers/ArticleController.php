<?php
namespace App\Admin\Controllers;

use App\Models\Article;
use App\Models\ArticleType;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Layout\Content;
use Encore\Admin\Show;

class ArticleController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'Books List';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new Article());
        $grid->column('id', __('Id'));
        $grid->column('title', __('Title'));
        $grid->column('ArticleType.title', __('Category'));
        // $grid->column('author', __('Author'));
        $grid->column('description', __('Description'))->style('max-width:200px;word-break:break-all;')->display(function ($val){
            return substr($val,0,30);
        });
        $grid->column('is_recommend', __('Recommend'))->bool();
        $grid->column('created_at', __('Created_at'));
        $grid->column('updated_at', __('Updated_at'));
        $grid->column('deleted_at', __('Deleted at'));

        return $grid;
    }

    /**
     * Make a show builder.
     *
     * @param mixed $id
     * @return Show
     */
    protected function detail($id)
    {
        $show = new Show(Article::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('title', __('title'));
        $show->field('type_id', __('Type_id'));
        $show->column('author', __('Author'));
        $show->field('description', __('Description'));
        $show->field('img', __('Thumbnail'))->image();
        $show->field('article_content', __('Article_content'));
        $show->field('is_recommend', __('Recommend'));
        $show->field('created_at', __('Created_at'));
        $show->field('updated_at', __('Updated_at'));


        return $show;
    }

    /**
     * Make a form builder.
     *
     * @return Form
     */
    protected function form()
    {
        $form = new Form(new Article());
        $form->select('type_id', __('Type_id'))->options((new ArticleType())::selectOptions());
        $form->text('title', __('Title'));
        $form->text('author', __('Author'));
        $form->text('description', __('Description'));
        $form->image('img', __('Thumbnail'))->uniqueName();
        $form->textarea('article_content', __('Article_content'))->attribute(['class' => 'ckeditor']);
        $states = [
        'on'  => ['value' => 1, 'text' => 'Recommend', 'color' => 'success'],
        'off' => ['value' => 0, 'text' => 'Not recommend', 'color' => 'danger'],
    ];
        $form->switch('is_recommend',__('Recommend'))->states($states);
        return $form;
    }

    public function moveImage()
    {
        // Mendapatkan path gambar dari direktori penyimpanan
        $sourcePath = storage_path('storage/app/images');

        // Mendapatkan path tujuan untuk memindahkan gambar
        $destinationPath = public_path('uploads/images/');

        // Memindahkan gambar
        File::move($sourcePath, $destinationPath);

        // Membuat respons atau melakukan operasi lain setelah pemindahan gambar
        return response()->json(['message' => 'Gambar berhasil dipindahkan']);
    }
}
