-- Write your PostgreSQL query statement below
with count_contact as  (
    select
        user_id,
        count(*) as contacts_cnt 
    from Contacts
    group by user_id
), count_trust_contact as (
    select a.user_id, count(*) as trusted_contacts_cnt
    from Contacts a 
    left join Customers b on a.contact_email = b.email
    where b.email is not null
    group by user_id

)
select a.invoice_id, 
       b.customer_name,
       a.price,
       coalesce(c.contacts_cnt,0) as contacts_cnt,
       coalesce(d.trusted_contacts_cnt,0) as trusted_contacts_cnt
from Invoices a
left join Customers b on a.user_id = b.customer_id
left join count_contact c on a.user_id = c.user_id
left join count_trust_contact d on a.user_id = d.user_id
order by a.invoice_id;
