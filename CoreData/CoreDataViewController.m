//
//  CoreDataViewController.m
//  CoreData
//
//  Created by dsierra on 7/11/13.
//  Copyright (c) 2013 mexlog. All rights reserved.
//

#import "CoreDataViewController.h"
#import "Category.h"
#import "Contacts.h"
#import "CoreDataAppDelegate.h"

@interface CoreDataViewController ()
@property CoreDataAppDelegate *appDelegate;
@property NSManagedObjectContext *context;
@property Contacts *contact;
@property Category *category;
@property NSArray *foundObjects;
@property int index;
@end

@implementation CoreDataViewController
@synthesize appDelegate, contact,category , context,foundObjects;
@synthesize addressField,nameTextField,phoneField, categoryField,statusLabel,index;

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = [[UIApplication sharedApplication] delegate];
    context = [appDelegate managedObjectContext];
    nameTextField.delegate = self;
    phoneField.delegate = self;
    addressField.delegate= self;
    categoryField.delegate = self;
    index = 0 ;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveContact:(id)sender {
    contact = [NSEntityDescription insertNewObjectForEntityForName:@"Contacts" inManagedObjectContext:context];
    contact.name = nameTextField.text;
    contact.phone = phoneField.text;
    contact.address = addressField.text;
    
    //Buscar si la categoria existe
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"Category" inManagedObjectContext:context];
    request.predicate = [NSPredicate predicateWithFormat:@"(name = %@)", categoryField.text];
    NSError *error;
    foundObjects = [context executeFetchRequest:request error:&error];
    if (foundObjects.count>0) {
        category = [foundObjects objectAtIndex:0];
    }
    else{
    category = [NSEntityDescription insertNewObjectForEntityForName:@"Category" inManagedObjectContext:context];
    }
    //
    
    
    category.name = categoryField.text;
    contact.category = category;
    [context save:&error];
    if(error){
        statusLabel.text = @"Contacto no fue salvado";
        
    }
    else
    {
        statusLabel.text = @"Cntacto guardado";
    }
    nameTextField.text=@"";
    addressField.text=@"";
    phoneField.text=@"";
    categoryField.text=@"";
    
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)findContact:(id)sender {
    if (![nameTextField.text isEqualToString:@""]) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        request.entity = [NSEntityDescription entityForName:@"Contacts" inManagedObjectContext:context];
        request.predicate = [NSPredicate predicateWithFormat:@"(name = %@)", nameTextField.text];
        NSError *error;
        foundObjects = [context executeFetchRequest:request error:&error];
        NSLog(@"%@",foundObjects);
        statusLabel.text = [NSString stringWithFormat:@"%d Contactos encontrados",foundObjects.count];
        Contacts *tempContact = [foundObjects objectAtIndex:0];
        addressField.text = tempContact.address;
        phoneField.text = tempContact.phone;
        categoryField.text = tempContact.category.name;
    }
    if (![categoryField.text isEqualToString:@""]) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        request.entity = [NSEntityDescription entityForName:@"Category" inManagedObjectContext:context];
        request.predicate = [NSPredicate predicateWithFormat:@"(name = %@)", categoryField.text];
        NSError *error;
        foundObjects = [context executeFetchRequest:request error:&error];
        if(foundObjects.count > 0)
        {
            Category *tempCategory = foundObjects[0];
            NSArray *tempArray = [tempCategory.contacts allObjects];
            statusLabel.text = [NSString stringWithFormat:@"%d Contactos encontrados",tempArray.count];
            Contacts *tempContact = [tempArray objectAtIndex:0];
            nameTextField.text = tempContact.name;
            addressField.text = tempContact.address;
            phoneField.text = tempContact.phone;
        }
        else {
            statusLabel.text = @"No existen categorias";
        }
    }
}

- (IBAction)nextAction:(id)sender {
    Category *tempCategory = foundObjects[0];
    if(index > [tempCategory.contacts allObjects].count-1)index=0;
    Contacts *tempContact = [tempCategory.contacts allObjects][index];
    nameTextField.text = tempContact.name;
    addressField.text = tempContact.address;
    phoneField.text = tempContact.phone;
    index++;
}
@end
