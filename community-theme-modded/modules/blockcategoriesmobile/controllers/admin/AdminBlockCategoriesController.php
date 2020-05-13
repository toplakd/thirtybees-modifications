<?php
/**
 * Copyright (C) 2017-2019 thirty bees
 * Copyright (C) 2007-2016 PrestaShop SA
 *
 * thirty bees is an extension to the PrestaShop software by PrestaShop SA.
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License (AFL 3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/afl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@thirtybees.com so we can send you a copy immediately.
 *
 * @author    thirty bees <modules@thirtybees.com>
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2017-2019 thirty bees
 * @copyright 2007-2016 PrestaShop SA
 * @license   Academic Free License (AFL 3.0)
 * PrestaShop is an internationally registered trademark of PrestaShop SA.
 */

/**
 * Class AdminBlockCategoriesController
 *
 * @since 1.0.0
 */
class AdminBlockCategoriesController extends ModuleAdminController
{
    /**
     * @since 1.0.0
     */
    public function postProcess()
    {
        if (($idThumb = Tools::getValue('deleteThumb', false)) !== false) {
            if (file_exists(_PS_CAT_IMG_DIR_.(int) Tools::getValue('id_category').'-'.(int) $idThumb.'_thumb.jpg')
                && !unlink(_PS_CAT_IMG_DIR_.(int) Tools::getValue('id_category').'-'.(int) $idThumb.'_thumb.jpg')
            ) {
                $this->context->controller->errors[] = Tools::displayError('Error while delete');
            }

            if (empty($this->context->controller->errors)) {
                Tools::clearSmartyCache();
            }

            Tools::redirectAdmin(Context::getContext()->link->getAdminLink('AdminCategories').'&id_category='.(int) Tools::getValue('id_category').'&updatecategory');
        }

        parent::postProcess();
    }

    /**
     * @since 1.0.0
     */
    public function ajaxProcessuploadThumbnailImages()
    {
        $category = new Category((int) Tools::getValue('id_category'));

        if (isset($_FILES['thumbnail'])) {
            //Get total of image already present in directory
            $files = scandir(_PS_CAT_IMG_DIR_);
            $assignedKeys = [];
            $allowedKeys = [0, 1, 2];
            foreach ($files as $file) {
                $matches = [];
                if (preg_match('/^'.$category->id.'-([0-9])?_thumb.jpg/i', $file, $matches) === 1) {
                    $assignedKeys[] = (int) $matches[1];
                }
            }

            $availableKeys = array_diff($allowedKeys, $assignedKeys);
            $helper = new HelperImageUploader('thumbnail');
            $files = $helper->process();
            $totalErrors = [];

            if (count($availableKeys) < count($files)) {
                $totalErrors['name'] = sprintf(Tools::displayError('An error occurred while uploading the image :'));
                $totalErrors['error'] = sprintf(Tools::displayError('You cannot upload more files'));
                die(json_encode(['thumbnail' => [$totalErrors]]));
            }

            foreach ($files as $key => &$file) {
                $id = array_shift($availableKeys);
                $errors = [];
                // Evaluate the memory required to resize the image: if it's too much, you can't resize it.
                if (isset($file['save_path']) && !ImageManager::checkImageMemoryLimit($file['save_path'])) {
                    $errors[] = Tools::displayError('Due to memory limit restrictions, this image cannot be loaded. Please increase your memory_limit value via your server\'s configuration settings. ');
                }
                // Copy new image
                if (!isset($file['save_path']) || (empty($errors) && !ImageManager::resize($file['save_path'], _PS_CAT_IMG_DIR_.(int) Tools::getValue('id_category').'-'.$id.'_thumb.jpg'))) {
                    $errors[] = Tools::displayError('An error occurred while uploading the image.');
                }

                if (count($errors)) {
                    $totalErrors = array_merge($totalErrors, $errors);
                }

                if (isset($file['save_path']) && is_file($file['save_path'])) {
                    unlink($file['save_path']);
                }
                //Necesary to prevent hacking
                if (isset($file['save_path'])) {
                    unset($file['save_path']);
                }

                if (isset($file['tmp_name'])) {
                    unset($file['tmp_name']);
                }

                //Add image preview and delete url
                $file['image'] = ImageManager::thumbnail(_PS_CAT_IMG_DIR_.(int) $category->id.'-'.$id.'_thumb.jpg', $this->context->controller->table.'_'.(int) $category->id.'-'.$id.'_thumb.jpg', 100, 'jpg', true, true);
                $file['delete_url'] = Context::getContext()->link->getAdminLink('AdminBlockCategories').'&deleteThumb='.$id.'&id_category='.(int) $category->id.'&updatecategory';
            }

            if (count($totalErrors)) {
                $this->context->controller->errors = array_merge($this->context->controller->errors, $totalErrors);
            } else {
                Tools::clearSmartyCache();
            }

            die(json_encode(['thumbnail' => $files]));
        }
    }
}
