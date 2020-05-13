{capture name=path}{l s='Your shopping cart'}{/capture}

<h1 id="cart_title" class="page-heading">{l s='Shopping-cart summary'}
  {if !isset($empty) && !$PS_CATALOG_MODE}
    <div class="pull-right">
      <span class="heading-counter badge">{l s='Your shopping cart contains:'}
        <span id="summary_products_quantity">{$productNumber} {if $productNumber == 1}{l s='product'}{else}{l s='products'}{/if}</span>
      </span>
    </div>
  {/if}
</h1>
{hook h='displayCartTop'}
{if isset($account_created)}
  <div class="alert alert-success">
    {l s='Your account has been created.'}
  </div>
{/if}

{if (isset($cannotModify) && $cannotModify == 1)}
<!-- dont show summary and steps on checkout page-->
{else}
{assign var='current_step' value='summary'}
{include file="$tpl_dir./order-steps.tpl"}
{/if}
{include file="$tpl_dir./errors.tpl"}

{if isset($empty)}
  <div class="alert alert-warning">{l s='Your shopping cart is empty.'}</div>
{elseif $PS_CATALOG_MODE}
  <div class="alert alert-warning">{l s='This store has not accepted your new order.'}</div>
{else}
  <div id="emptyCartWarning" class="alert alert-warning unvisible">{l s='Your shopping cart is empty.'}</div>
  {* if isset($lastProductAdded) AND $lastProductAdded}
    <div class="cart_last_product" style="display: none;">
      <div class="cart_last_product_header">
        <div class="left">{l s='Last product added'}</div>
      </div>
      <a class="cart_last_product_img" href="{$link->getProductLink($lastProductAdded.id_product, $lastProductAdded.link_rewrite, $lastProductAdded.category, null, null, $lastProductAdded.id_shop)|escape:'html':'UTF-8'}">
        <img src="{$link->getImageLink($lastProductAdded.link_rewrite, $lastProductAdded.id_image, 'small_default')|escape:'html':'UTF-8'}" alt="{$lastProductAdded.name|escape:'html':'UTF-8'}">
      </a>
      <div class="cart_last_product_content">
        <p class="product-name">
          <a href="{$link->getProductLink($lastProductAdded.id_product, $lastProductAdded.link_rewrite, $lastProductAdded.category, null, null, null, $lastProductAdded.id_product_attribute)|escape:'html':'UTF-8'}">
            {$lastProductAdded.name|escape:'html':'UTF-8'}
          </a>
        </p>
        {if isset($lastProductAdded.attributes) && $lastProductAdded.attributes}
          <small>
            <a href="{$link->getProductLink($lastProductAdded.id_product, $lastProductAdded.link_rewrite, $lastProductAdded.category, null, null, null, $lastProductAdded.id_product_attribute)|escape:'html':'UTF-8'}">
              {$lastProductAdded.attributes|escape:'html':'UTF-8'}
            </a>
          </small>
        {/if}
      </div>
    </div>
  {/if *}
  {assign var='total_discounts_num' value="{if $total_discounts != 0}1{else}0{/if}"}
  {assign var='use_show_taxes' value="{if $use_taxes && $show_taxes}2{else}0{/if}"}
  {assign var='total_wrapping_taxes_num' value="{if $total_wrapping != 0}1{else}0{/if}"}
  {* eu-legal *}
  {hook h="displayBeforeShoppingCartBlock"}
  <div id="order-detail-content" class="">
    <div id="cart_summary">

      <div class="">
        <div class="cart_summary">
          <span class="cart_product">{l s='Product'}</span>
          <span class="cart_description">{l s='Description'}</span>
            <div class="cart_container_row">
              <span class="cart_unit text-right">{l s='Unit price'}</span>
              <span class="cart_quantity text-center">{l s='Qty'}</span>
              <span class="cart_total text-right">{l s='Total'}</span>
            </div>
          <div class="cart_summary_mobile text-center">{l s='Your shopping cart contains:'} {$productNumber} {if $productNumber == 1}{l s='product'}{else}{l s='products'}{/if}</div>
        </div>
      {assign var='odd' value=0}
      {assign var='have_non_virtual_products' value=false}
      {foreach $products as $product}
        {if $product.is_virtual == 0}
          {assign var='have_non_virtual_products' value=true}
        {/if}
        {assign var='productId' value=$product.id_product}
        {assign var='productAttributeId' value=$product.id_product_attribute}
        {assign var='quantityDisplayed' value=0}
        {assign var='odd' value=($odd+1)%2}
        {assign var='ignoreProductLast' value=isset($customizedDatas.$productId.$productAttributeId) || count($gift_products)}
        {* Display the product line *}
        {include file="$tpl_dir./shopping-cart-product-line.tpl" productLast=$product@last productFirst=$product@first}
        {* Then the customized datas ones*}
        {if isset($customizedDatas.$productId.$productAttributeId[$product.id_address_delivery])}
          {foreach $customizedDatas.$productId.$productAttributeId[$product.id_address_delivery] as $id_customization=>$customization}
            <div
              id="product_{$product.id_product}_{$product.id_product_attribute}_{$id_customization}_{$product.id_address_delivery|intval}"
              class="product_customization_for_{$product.id_product}_{$product.id_product_attribute}_{$product.id_address_delivery|intval}{if $odd} odd{else} even{/if} customization">
              <div></div>
              <div class="cart_customization">
                {foreach $customization.datas as $type => $custom_data}
                  {if $type == $CUSTOMIZE_FILE}
                    <div class="customizationUploaded">
                      <ul class="customizationUploaded">
                        {foreach $custom_data as $picture}
                          <li><img src="{$pic_dir}{$picture.value}_small" alt="" class="customizationUploaded"></li>
                        {/foreach}
                      </ul>
                    </div>
                  {elseif $type == $CUSTOMIZE_TEXTFIELD}
                    <ul class="typedText">
                      {foreach $custom_data as $textField}
                        <li>
                          {if $textField.name}
                            <div class="customization-badge small">{$textField.name}</div>
                          {else}
                            <div class="customization-badge small">{l s='Text #'}{$textField@index+1}</div>
                          {/if}
                            <ul><li class="customization-text small">{$textField.value}</li></ul>
                        </li>
                      {/foreach}
                    </ul>
                  {/if}
                {/foreach}
              </div>
              <div class="cart_quantity text-center">
                {if isset($cannotModify) AND $cannotModify == 1}
                  <span>{if $quantityDisplayed == 0 AND isset($customizedDatas.$productId.$productAttributeId)}{$customizedDatas.$productId.$productAttributeId|@count}{else}{$product.cart_quantity-$quantityDisplayed}{/if}</span>
                {else}
                  <div class="cart_quantity_button clearfix">
                  <input type="hidden" value="{$customization.quantity}" name="quantity_{$product.id_product}_{$product.id_product_attribute}_{$id_customization}_{$product.id_address_delivery|intval}_hidden">
                  <input type="text" value="{$customization.quantity}" class="cart_quantity_input form-control text-center" name="quantity_{$product.id_product}_{$product.id_product_attribute}_{$id_customization}_{$product.id_address_delivery|intval}">

                    {if $product.minimal_quantity < ($customization.quantity -$quantityDisplayed) OR $product.minimal_quantity <= 1}
                    <a
                      id="cart_quantity_up_{$product.id_product}_{$product.id_product_attribute}_{$id_customization}_{$product.id_address_delivery|intval}"
                      class="cart_quantity_up btn btn-default button-plus"
                      href="{$link->getPageLink('cart', true, NULL, "add=1&amp;id_product={$product.id_product|intval}&amp;ipa={$product.id_product_attribute|intval}&amp;id_address_delivery={$product.id_address_delivery}&amp;id_customization={$id_customization}&amp;token={$token_cart}")|escape:'html':'UTF-8'}"
                      rel="nofollow"
                      title="{l s='Add'}">
                      <i class="icon icon-fw icon-plus"></i>
                    </a>
                      <a
                        id="cart_quantity_down_{$product.id_product}_{$product.id_product_attribute}_{$id_customization}_{$product.id_address_delivery|intval}"
                        class="cart_quantity_down btn btn-default button-minus"
                        href="{$link->getPageLink('cart', true, NULL, "add=1&amp;id_product={$product.id_product|intval}&amp;ipa={$product.id_product_attribute|intval}&amp;id_address_delivery={$product.id_address_delivery}&amp;id_customization={$id_customization}&amp;op=down&amp;token={$token_cart}")|escape:'html':'UTF-8'}"
                        rel="nofollow"
                        title="{l s='Subtract'}">
                        <i class="icon icon-fw icon-minus"></i>
                      </a>
                    {else}
                      <a
                        id="cart_quantity_down_{$product.id_product}_{$product.id_product_attribute}_{$id_customization}"
                        class="cart_quantity_down btn btn-default button-minus disabled"
                        href="#"
                        title="{l s='Subtract'}">
                        <i class="icon icon-fw icon-minus"></i>
                      </a>
                    {/if}

                  </div>
                {/if}

              </div>
              <div class="cart_delete">
                  <a
                    id="{$product.id_product}_{$product.id_product_attribute}_{$id_customization}_{$product.id_address_delivery|intval}"
                    class="cart_quantity_delete"
                    href="{$link->getPageLink('cart', true, NULL, "delete=1&amp;id_product={$product.id_product|intval}&amp;ipa={$product.id_product_attribute|intval}&amp;id_customization={$id_customization}&amp;id_address_delivery={$product.id_address_delivery}&amp;token={$token_cart}")|escape:'html':'UTF-8'}"
                    rel="nofollow"
                    title="{l s='Delete'}">
                    <i class="icon icon-trash"></i>
                  </a>
              </div>
            </div>
            {assign var='quantityDisplayed' value=$quantityDisplayed+$customization.quantity}
          {/foreach}

          {* If it exists also some uncustomized products *}
          {if $product.quantity-$quantityDisplayed > 0}{include file="$tpl_dir./shopping-cart-product-line.tpl" productLast=$product@last productFirst=$product@first}{/if}
        {/if}
      {/foreach}
      {assign var='last_was_odd' value=$product@iteration%2}
      {foreach $gift_products as $product}
        {assign var='productId' value=$product.id_product}
        {assign var='productAttributeId' value=$product.id_product_attribute}
        {assign var='quantityDisplayed' value=0}
        {assign var='odd' value=($product@iteration+$last_was_odd)%2}
        {assign var='ignoreProductLast' value=isset($customizedDatas.$productId.$productAttributeId)}
        {assign var='cannotModify' value=1}
        {* Display the gift product line *}
        {include file="$tpl_dir./shopping-cart-product-line.tpl" productLast=$product@last productFirst=$product@first}
      {/foreach}
      {if sizeof($discounts)}
        {foreach $discounts as $discount}
          {if ($discount.value_real|floatval == 0 && $discount.free_shipping != 1) || ($discount.value_real|floatval == 0 && $discount.code == '')}
            {continue}
          {/if}
          <div class="cart_discount" id="cart_discount_{$discount.id_discount}">
            <div class="cart_discount_name">{$discount.name}</div>
            <div class="cart_discount_price text-center">
              <span class="price-discount price">{if !$priceDisplay}{displayPrice price=$discount.value_real*-1}{else}{displayPrice price=$discount.value_tax_exc*-1}{/if}</span>
            </div>
            <div class="cart_delete">
              {if strlen($discount.code)}
                <a
                  href="{if $opc}{$link->getPageLink('order-opc', true)}{else}{$link->getPageLink('order', true)}{/if}?deleteDiscount={$discount.id_discount}"
                  class="price_discount_delete"
                  title="{l s='Delete'}">
                  <i class="icon icon-trash"></i>
                </a>
              {/if}
            </div>
          </div>
        {/foreach}
      {/if}
      </div>

      <div class="cart_footer_container">
          <div class="cart_total_footer">
            {if $use_taxes}
    
              {if $priceDisplay}
                <div class="cart_total_price">
                <div class="text_total">{if $display_tax_label}{l s='Total products (tax excl.)'}{else}{l s='Total products'}{/if}</div>
                <div class="price" id="total_product">{displayPrice price=$total_products}</div>
              </div>
              {else}
                <div class="cart_total_price">
                <div class="text_total">{if $display_tax_label}{l s='Total products (tax incl.)'}{else}{l s='Total products'}{/if}</div>
                <div class="price" id="total_product">{displayPrice price=$total_products_wt}</div>
              </div>
              {/if}
    
            {else}
              <div class="cart_total_price">
                <div class="text_total">{l s='Total products'}</div>
                <div class="price" id="total_product">{displayPrice price=$total_products}</div>
              </div>
            {/if}
    
            <div class="total_wrapping"{if $total_wrapping == 0} style="display: none;"{/if}>
            <div class="text_total">
              {if $use_taxes}
                {if $display_tax_label}{l s='Total gift wrapping (tax incl.)'}{else}{l s='Total gift-wrapping cost'}{/if}
              {else}
                {l s='Total gift-wrapping cost'}
              {/if}
            </div>
            <div class="price-discount price" id="total_wrapping">
              {if $use_taxes}
                {if $priceDisplay}
                  {displayPrice price=$total_wrapping_tax_exc}
                {else}
                  {displayPrice price=$total_wrapping}
                {/if}
              {else}
                {displayPrice price=$total_wrapping_tax_exc}
              {/if}
            </div>
          </div>
    
            {if $total_shipping_tax_exc <= 0 && (!isset($isVirtualCart) || !$isVirtualCart) && $free_ship}
            <div class="cart_total_delivery{if !$opc && (!isset($cart->id_address_delivery) || !$cart->id_address_delivery)} unvisible{/if}">
              <div class="text_total">{l s='Total shipping'}</div>
              <div class="price" id="total_shipping">{l s='Free shipping!'}</div>
            </div>
            {else}
              {if $use_taxes && $total_shipping_tax_exc != $total_shipping}
                {if $priceDisplay}
                <div class="cart_total_delivery{if $total_shipping_tax_exc <= 0} unvisible{/if}">
                  <div class="text_total">{if $display_tax_label}{l s='Total shipping (tax excl.)'}{else}{l s='Total shipping'}{/if}</div>
                  <div class="price" id="total_shipping">{displayPrice price=$total_shipping_tax_exc}</div>
                </div>
                {else}
                <div class="cart_total_delivery{if $total_shipping <= 0} unvisible{/if}">
                  <div class="text_total">{if $display_tax_label}{l s='Total shipping (tax incl.)'}{else}{l s='Total shipping'}{/if}</div>
                  <div class="price" id="total_shipping" >{displayPrice price=$total_shipping}</div>
                </div>
                {/if}
              {else}
              <div class="cart_total_delivery{if $total_shipping_tax_exc <= 0} unvisible{/if}">
                <div class="text_total">{l s='Total shipping'}</div>
                <div class="price" id="total_shipping" >{displayPrice price=$total_shipping_tax_exc}</div>
              </div>
              {/if}
            {/if}
    
            <div class="shipping_error" style="display:none">
              <div class="text-left" style=""></div>
            </div>
    
            <div class="cart_total_voucher{if $total_discounts == 0} unvisible{/if}">
              <div class="text_total">
                {if $display_tax_label}
                  {if $use_taxes && $priceDisplay == 0}
                    {l s='Total vouchers (tax incl.)'}
                  {else}
                    {l s='Total vouchers (tax excl.)'}
                  {/if}
                {else}
                  {l s='Total vouchers'}
                {/if}
              </div>
              <div class="price-discount price" id="total_discount">
                {if $use_taxes && $priceDisplay == 0}
                  {assign var='total_discounts_negative' value=$total_discounts * -1}
                {else}
                  {assign var='total_discounts_negative' value=$total_discounts_tax_exc * -1}
                {/if}
                {displayPrice price=$total_discounts_negative}
              </div>
            </div>
    
            {if $use_taxes && $show_taxes && $total_tax != 0 }
    
              {if $priceDisplay != 0}
                <div class="cart_total_price">
                  <div class="text_total">{if $display_tax_label}{l s='Total (tax excl.)'}{else}{l s='Total'}{/if}</div>
                  <div class="price" id="total_price_without_tax">{displayPrice price=$total_price_without_tax}</div>
                </div>
              {/if}
    
              <div class="cart_total_tax">
                <div class="text_total">{l s='Tax'}</div>
                <div class="price" id="total_tax">{displayPrice price=$total_tax}</div>
              </div>
            {/if}
    
            <div class="cart_total_price">
              <div class="total_price_container text_total">
                <span>{l s='Total'}</span>
                <div class="hookDisplayProductPriceBlock-price">
                  {hook h="displayCartTotalPriceLabel"}
                </div>
              </div>
              {if $use_taxes}
                <div class="price" id="total_price_container">
                  <span id="total_price">{displayPrice price=$total_price}</span>
                </div>
              {else}
                <div class="price" id="total_price_container">
                  <span id="total_price">{displayPrice price=$total_price_without_tax}</span>
                </div>
              {/if}
            </div>
    
          </div>



        <div id="cart_voucher" class="cart_voucher">
          {if $voucherAllowed}
            {if isset($cannotModify) AND $cannotModify == 1}
            {else}
            <form action="{if $opc}{$link->getPageLink('order-opc', true)}{else}{$link->getPageLink('order', true)}{/if}" method="post" id="voucher">
              <fieldset>
                <h4>{l s='Vouchers'}</h4>
                <input type="text" class="discount_name form-control" id="discount_name" name="discount_name" value="{if isset($discount_name) && $discount_name}{$discount_name}{/if}">
                <input type="hidden" name="submitDiscount">
                <button type="submit" name="submitAddDiscount" class="btn btn-primary"><span>{l s='OK'}</span></button>
              </fieldset>
            </form>
            {/if}
            {if $displayVouchers}
              <p id="title" class="title-offers">{l s='Take advantage of our exclusive offers:'}</p>
              <div id="display_cart_vouchers">
                {foreach $displayVouchers as $voucher}
                  {if $voucher.code != ''}<span class="voucher_name" data-code="{$voucher.code|escape:'html':'UTF-8'}">{$voucher.code|escape:'html':'UTF-8'}</span> - {/if}{$voucher.name}<br>
                {/foreach}
              </div>
            {/if}
          {/if}
        </div>
      </div>

    </div>
  </div>

  {if $show_option_allow_separate_package}
    <div class="checkbox">
      <label for="allow_seperated_package" class="inline">
        <input type="checkbox" name="allow_seperated_package" id="allow_seperated_package" {if $cart->allow_seperated_package}checked="checked"{/if} autocomplete="off">
        {l s='Send available products first'}
      </label>
    </div>
  {/if}


  {if $current_step=='payment'}
  {if !$advanced_payment_api && ((!empty($delivery_option) && (!isset($isVirtualCart) || !$isVirtualCart)) OR $delivery->id || $invoice->id) && !$opc}
    <div class="order_delivery clearfix row">
      {if !isset($formattedAddresses) || (count($formattedAddresses.invoice) == 0 && count($formattedAddresses.delivery) == 0) || (count($formattedAddresses.invoice.formated) == 0 && count($formattedAddresses.delivery.formated) == 0)}
        {if $delivery->id}
          <div class="col-xs-12 col-sm-6"{if !$have_non_virtual_products} style="display: none;"{/if}>
            <ul id="delivery_address" class="address box">
              <li><h3 class="page-subheading">{l s='Delivery address'}&nbsp;<span class="address_alias">({$delivery->alias})</span></h3></li>
              {if $delivery->company}<li class="address_company">{$delivery->company|escape:'html':'UTF-8'}</li>{/if}
              <li class="address_name">{$delivery->firstname|escape:'html':'UTF-8'} {$delivery->lastname|escape:'html':'UTF-8'}</li>
              <li class="address_address1">{$delivery->address1|escape:'html':'UTF-8'}</li>
              {if $delivery->address2}<li class="address_address2">{$delivery->address2|escape:'html':'UTF-8'}</li>{/if}
              <li class="address_city">{$delivery->postcode|escape:'html':'UTF-8'} {$delivery->city|escape:'html':'UTF-8'}</li>
              <li class="address_country">{$delivery->country|escape:'html':'UTF-8'} {if $delivery_state}({$delivery_state|escape:'html':'UTF-8'}){/if}</li>
            </ul>
          </div>
        {/if}
        {if $invoice->id}
          <div class="col-xs-12 col-sm-6">
            <ul id="invoice_address" class="address box">
              <li><h3 class="page-subheading">{l s='Invoice address'}&nbsp;<span class="address_alias">({$invoice->alias})</span></h3></li>
              {if $invoice->company}<li class="address_company">{$invoice->company|escape:'html':'UTF-8'}</li>{/if}
              <li class="address_name">{$invoice->firstname|escape:'html':'UTF-8'} {$invoice->lastname|escape:'html':'UTF-8'}</li>
              <li class="address_address1">{$invoice->address1|escape:'html':'UTF-8'}</li>
              {if $invoice->address2}<li class="address_address2">{$invoice->address2|escape:'html':'UTF-8'}</li>{/if}
              <li class="address_city">{$invoice->postcode|escape:'html':'UTF-8'} {$invoice->city|escape:'html':'UTF-8'}</li>
              <li class="address_country">{$invoice->country|escape:'html':'UTF-8'} {if $invoice_state}({$invoice_state|escape:'html':'UTF-8'}){/if}</li>
            </ul>
          </div>
        {/if}
      {else}
        {foreach from=$formattedAddresses key=k item=address}
          <div class="col-xs-12 col-sm-6"{if $k == 'delivery' && !$have_non_virtual_products} style="display: none;"{/if}>
            <ul class="address box">
              <li>
                <h3 class="page-subheading">
                  {if $k eq 'invoice'}
                    {l s='Invoice address'}
                  {elseif $k eq 'delivery' && $delivery->id}
                    {l s='Delivery address'}
                  {/if}
                  {if isset($address.object.alias)}
                    <span class="address_alias">({$address.object.alias})</span>
                  {/if}
                </h3>
              </li>
              {foreach $address.ordered as $pattern}
                {assign var=addressKey value=" "|explode:$pattern}
                {assign var=addedli value=false}
                {foreach from=$addressKey item=key name=foo}
                  {$key_str = $key|regex_replace:AddressFormat::_CLEANING_REGEX_:""}
                  {if isset($address.formated[$key_str]) && !empty($address.formated[$key_str])}
                    {if (!$addedli)}
                      {$addedli = true}
                      <li><span class="{if isset($addresses_style[$key_str])}{$addresses_style[$key_str]}{/if}">
                    {/if}
                    {$address.formated[$key_str]|escape:'html':'UTF-8'}
                  {/if}
                  {if ($smarty.foreach.foo.last && $addedli)}
                    </span></li>
                  {/if}
                {/foreach}
              {/foreach}
            </ul>
          </div>
        {/foreach}
      {/if}
    </div>
  {/if}
  {/if}


<!-- don't show buttons on payment page -->
{if (isset($cannotModify) && $cannotModify == 1)}
<!-- don't show buttons on payment page -->
{else}


  <p class="cart_navigation clearfix">
    {if !$opc}
      <a  href="{if $back}{$link->getPageLink('order', true, NULL, 'step=1&amp;back={$back}')|escape:'html':'UTF-8'}{else}{$link->getPageLink('order', true, NULL, 'step=1')|escape:'html':'UTF-8'}{/if}"
          class="btn btn-lg btn-success pull-right standard-checkout btn-full" title="{l s='Proceed to checkout'}">
        <span>{l s='Proceed to checkout'} <i class="icon icon-chevron-right"></i></span>
      </a>
    {/if}
    <a href="{if (isset($smarty.server.HTTP_REFERER) && ($smarty.server.HTTP_REFERER == $link->getPageLink('order', true) || $smarty.server.HTTP_REFERER == $link->getPageLink('order-opc', true) || strstr($smarty.server.HTTP_REFERER, 'step='))) || !isset($smarty.server.HTTP_REFERER)}{$link->getPageLink('index')}{else}{$smarty.server.HTTP_REFERER|regex_replace:'/[\?|&]content_only=1/':''|escape:'html':'UTF-8'|secureReferrer}{/if}"
       class="btn btn-lg btn-default btn-full" title="{l s='Continue shopping'}">
      <i class="icon icon-chevron-left"></i> {l s='Continue shopping'}
    </a>
  </p>

  <div id="HOOK_SHOPPING_CART">{$HOOK_SHOPPING_CART}</div>

{/if}

  <div class="clear"></div>
  <div class="cart_navigation_extra">
    <div id="HOOK_SHOPPING_CART_EXTRA">{if isset($HOOK_SHOPPING_CART_EXTRA)}{$HOOK_SHOPPING_CART_EXTRA}{/if}</div>
  </div>
  {strip}
    {addJsDef deliveryAddress=$cart->id_address_delivery|intval}
    {addJsDefL name=txtProduct}{l s='product' js=1}{/addJsDefL}
    {addJsDefL name=txtProducts}{l s='products' js=1}{/addJsDefL}
  {/strip}
{/if}
