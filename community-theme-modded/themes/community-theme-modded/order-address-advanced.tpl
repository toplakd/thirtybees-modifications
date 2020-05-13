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