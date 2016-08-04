//
//  PokemonHelper.m
//  PokeGoMap
//
//  Created by Digby Andrews on 2016-08-02.
//  Copyright © 2016 Digby Andrews. All rights reserved.
//

#import "PokemonHelper.h"
#import "PokemonBase.h"

@interface PokemonHelper ()
@property (nonatomic) NSDictionary<NSString*, PokemonBase *> *pokemonDictionary;

@end

@implementation PokemonHelper

+ (instancetype)sharedObject
{
    static PokemonHelper *instance;
    
    if (!instance)
    {
        instance = [[PokemonHelper alloc] init];
    }
    
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _pokemonDictionary = [NSKeyedUnarchiver unarchiveObjectWithFile:[self path]];
        
        if (!_pokemonDictionary)
        {
            _pokemonDictionary = [self getPokemonFromDictionary];
        }
    }
    
    return self;
}

- (NSString *) path
{
    NSArray *dir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[dir firstObject] stringByAppendingPathComponent:@"pokemon.txt"];
}

- (void)switchVisibilityForPokemonNumber:(NSNumber *)pokemonNumber
{
    PokemonBase *pokemon = [self.pokemonDictionary objectForKey:[NSString stringWithFormat:@"%@",pokemonNumber]];
    BOOL isVisible = [pokemon.isPokemonVisible boolValue];
    pokemon.isPokemonVisible = [NSNumber numberWithBool:!isVisible];
}

- (void)saveChanges
{
    [NSKeyedArchiver archiveRootObject:self.pokemonDictionary toFile:[self path]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pokemonDictionary.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell"];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PokemonCell"];
    }
    
    UIImageView *imageView = [cell.contentView viewWithTag:1];
    UILabel *labelView = [cell.contentView viewWithTag:2];
    UISwitch *switchView = [cell.contentView viewWithTag:3];
    
    NSString *key = [NSString stringWithFormat:@"%ld",(indexPath.row + 1)];
    PokemonBase *pokemon = [self.pokemonDictionary objectForKey:key];
    
    imageView.image = [UIImage imageNamed:key];
    labelView.text = [NSString stringWithFormat:@"#%@ - %@",key,pokemon.pokemonName];
    
    [switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    [switchView setOn:[pokemon.isPokemonVisible boolValue]];
    
    return cell;
}

- (void) switchChanged:(UISwitch *) sender
{
    UITableView *tableView = (UITableView *) sender.superview.superview.superview.superview;
    UITableViewCell *cell = (UITableViewCell *) sender.superview.superview;
    NSIndexPath *indexPath = [tableView indexPathForCell:cell];
    [self switchVisibilityForPokemonNumber:[NSNumber numberWithLong:(indexPath.row + 1)]];
}

-(NSDictionary *)getPokemonFromDictionary
{
    
    NSMutableDictionary *pokeDictionary = [NSMutableDictionary dictionary];
    
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Bulbasaur" ID:[NSNumber numberWithInt:1] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"1"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Ivysaur" ID:[NSNumber numberWithInt:2] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"2"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Venosaur" ID:[NSNumber numberWithInt:3] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"3"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Charmander" ID:[NSNumber numberWithInt:4] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"4"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Charmeleon" ID:[NSNumber numberWithInt:5] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"5"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Charizard" ID:[NSNumber numberWithInt:6] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"6"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Squirtle" ID:[NSNumber numberWithInt:7] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"7"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Wartortle" ID:[NSNumber numberWithInt:8] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"8"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Blastoise" ID:[NSNumber numberWithInt:9] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"9"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Caterpie" ID:[NSNumber numberWithInt:10] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"10"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Metapod" ID:[NSNumber numberWithInt:11] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"11"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Butterfree" ID:[NSNumber numberWithInt:12] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"12"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Weedle" ID:[NSNumber numberWithInt:13] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"13"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Kakuna" ID:[NSNumber numberWithInt:14] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"14"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Beedrill" ID:[NSNumber numberWithInt:15] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"15"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Pidgey" ID:[NSNumber numberWithInt:16] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"16"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Pidgeotto" ID:[NSNumber numberWithInt:17] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"17"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Pidgeot" ID:[NSNumber numberWithInt:18] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"18"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Rattata" ID:[NSNumber numberWithInt:19] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"19"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Raticate" ID:[NSNumber numberWithInt:20] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"20"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Spearow" ID:[NSNumber numberWithInt:21] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"21"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Fearow" ID:[NSNumber numberWithInt:22] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"22"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Ekans" ID:[NSNumber numberWithInt:23] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"23"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Arbok" ID:[NSNumber numberWithInt:24] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"24"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Pikachu" ID:[NSNumber numberWithInt:25] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"25"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Raichu" ID:[NSNumber numberWithInt:26] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"26"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Sandshrew" ID:[NSNumber numberWithInt:27] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"27"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Sandslash" ID:[NSNumber numberWithInt:28] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"28"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Nidoran♀" ID:[NSNumber numberWithInt:29] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"29"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Nidorina" ID:[NSNumber numberWithInt:30] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"30"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Nidoqueen" ID:[NSNumber numberWithInt:31] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"31"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Nidoran♂" ID:[NSNumber numberWithInt:32] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"32"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Nidorino" ID:[NSNumber numberWithInt:33] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"33"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Nidoking" ID:[NSNumber numberWithInt:34] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"34"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Clefairy" ID:[NSNumber numberWithInt:35] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"35"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Clefable" ID:[NSNumber numberWithInt:36] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"36"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Vulpix" ID:[NSNumber numberWithInt:37] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"37"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Ninetales" ID:[NSNumber numberWithInt:38] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"38"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Jigglypuff" ID:[NSNumber numberWithInt:39] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"39"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Wigglytuff" ID:[NSNumber numberWithInt:40] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"40"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Zubat" ID:[NSNumber numberWithInt:41] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"41"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Golbat" ID:[NSNumber numberWithInt:42] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"42"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Oddish" ID:[NSNumber numberWithInt:43] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"43"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Gloom" ID:[NSNumber numberWithInt:44] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"44"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Vileplume" ID:[NSNumber numberWithInt:45] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"45"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Paras" ID:[NSNumber numberWithInt:46] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"46"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Parasect" ID:[NSNumber numberWithInt:47] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"47"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Venonat" ID:[NSNumber numberWithInt:48] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"48"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Venomoth" ID:[NSNumber numberWithInt:49] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"49"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Diglett" ID:[NSNumber numberWithInt:50] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"50"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Dugtrio" ID:[NSNumber numberWithInt:51] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"51"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Meowth" ID:[NSNumber numberWithInt:52] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"52"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Persian" ID:[NSNumber numberWithInt:53] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"53"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Psyduck" ID:[NSNumber numberWithInt:54] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"54"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Golduck" ID:[NSNumber numberWithInt:55] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"55"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Mankey" ID:[NSNumber numberWithInt:56] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"56"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Primeape" ID:[NSNumber numberWithInt:57] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"57"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Growlithe" ID:[NSNumber numberWithInt:58] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"58"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Arcanine" ID:[NSNumber numberWithInt:59] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"59"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Poliwag" ID:[NSNumber numberWithInt:60] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"60"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Poliwhirl" ID:[NSNumber numberWithInt:61] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"61"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Poliwrath" ID:[NSNumber numberWithInt:62] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"62"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Abra" ID:[NSNumber numberWithInt:63] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"63"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Kadabra" ID:[NSNumber numberWithInt:64] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"64"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Alakazam" ID:[NSNumber numberWithInt:65] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"65"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Machop" ID:[NSNumber numberWithInt:66] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"66"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Machoke" ID:[NSNumber numberWithInt:67] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"67"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Machamp" ID:[NSNumber numberWithInt:68] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"68"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Bellsprout" ID:[NSNumber numberWithInt:69] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"69"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Weepinbell" ID:[NSNumber numberWithInt:70] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"70"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Victreebel" ID:[NSNumber numberWithInt:71] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"71"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Tentacool" ID:[NSNumber numberWithInt:72] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"72"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Tentacruel" ID:[NSNumber numberWithInt:73] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"73"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Geodude" ID:[NSNumber numberWithInt:74] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"74"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Graveler" ID:[NSNumber numberWithInt:75] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"75"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Golem" ID:[NSNumber numberWithInt:76] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"76"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Ponyta" ID:[NSNumber numberWithInt:77] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"77"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Rapidash" ID:[NSNumber numberWithInt:78] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"78"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Slowpoke" ID:[NSNumber numberWithInt:79] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"79"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Slowbro" ID:[NSNumber numberWithInt:80] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"80"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Magnemite" ID:[NSNumber numberWithInt:81] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"81"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Magneton" ID:[NSNumber numberWithInt:82] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"82"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Farfetch'd" ID:[NSNumber numberWithInt:83] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"83"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Doduo" ID:[NSNumber numberWithInt:84] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"84"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Dodrio" ID:[NSNumber numberWithInt:85] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"85"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Seel" ID:[NSNumber numberWithInt:86] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"86"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Dewgong" ID:[NSNumber numberWithInt:87] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"87"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Grimer" ID:[NSNumber numberWithInt:88] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"88"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Muk" ID:[NSNumber numberWithInt:89] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"89"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Shellder" ID:[NSNumber numberWithInt:90] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"90"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Cloyster" ID:[NSNumber numberWithInt:91] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"91"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Gastly" ID:[NSNumber numberWithInt:92] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"92"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Haunter" ID:[NSNumber numberWithInt:93] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"93"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Gengar" ID:[NSNumber numberWithInt:94] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"94"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Onix" ID:[NSNumber numberWithInt:95] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"95"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Drowzee" ID:[NSNumber numberWithInt:96] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"96"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Hypno" ID:[NSNumber numberWithInt:97] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"97"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Krabby" ID:[NSNumber numberWithInt:98] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"98"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Kingler" ID:[NSNumber numberWithInt:99] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"99"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Voltorb" ID:[NSNumber numberWithInt:100] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"100"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Electrode" ID:[NSNumber numberWithInt:101] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"101"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Exeggcute" ID:[NSNumber numberWithInt:102] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"102"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Exeggutor" ID:[NSNumber numberWithInt:103] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"103"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Cubone" ID:[NSNumber numberWithInt:104] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"104"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Marowak" ID:[NSNumber numberWithInt:105] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"105"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Hitmonlee" ID:[NSNumber numberWithInt:106] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"106"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Hitmonchan" ID:[NSNumber numberWithInt:107] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"107"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Lickitung" ID:[NSNumber numberWithInt:108] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"108"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Koffing" ID:[NSNumber numberWithInt:109] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"109"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Weezing" ID:[NSNumber numberWithInt:110] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"110"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Rhyhorn" ID:[NSNumber numberWithInt:111] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"111"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Rhydon" ID:[NSNumber numberWithInt:112] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"112"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Chansey" ID:[NSNumber numberWithInt:113] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"113"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Tangela" ID:[NSNumber numberWithInt:114] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"114"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Kangaskhan" ID:[NSNumber numberWithInt:115] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"115"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Horsea" ID:[NSNumber numberWithInt:116] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"116"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Seadra" ID:[NSNumber numberWithInt:117] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"117"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Goldeen" ID:[NSNumber numberWithInt:118] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"118"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Seaking" ID:[NSNumber numberWithInt:119] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"119"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Staryu" ID:[NSNumber numberWithInt:120] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"120"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Starmie" ID:[NSNumber numberWithInt:121] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"121"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Mr. Mime" ID:[NSNumber numberWithInt:122] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"122"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Scyther" ID:[NSNumber numberWithInt:123] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"123"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Jynx" ID:[NSNumber numberWithInt:124] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"124"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Electabuzz" ID:[NSNumber numberWithInt:125] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"125"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Magmar" ID:[NSNumber numberWithInt:126] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"126"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Pinsir" ID:[NSNumber numberWithInt:127] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"127"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Tauros" ID:[NSNumber numberWithInt:128] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"128"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Magikarp" ID:[NSNumber numberWithInt:129] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"129"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Gyarados" ID:[NSNumber numberWithInt:130] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"130"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Lapras" ID:[NSNumber numberWithInt:131] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"131"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Ditto" ID:[NSNumber numberWithInt:132] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"132"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Eevee" ID:[NSNumber numberWithInt:133] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"133"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Vaporeon" ID:[NSNumber numberWithInt:134] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"134"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Jolteon" ID:[NSNumber numberWithInt:135] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"135"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Flareon" ID:[NSNumber numberWithInt:136] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"136"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Porygon" ID:[NSNumber numberWithInt:137] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"137"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Omanyte" ID:[NSNumber numberWithInt:138] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"138"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Omastar" ID:[NSNumber numberWithInt:139] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"139"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Kabuto" ID:[NSNumber numberWithInt:140] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"140"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Kabutops" ID:[NSNumber numberWithInt:141] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"141"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Aerodactyl" ID:[NSNumber numberWithInt:142] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"142"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Snorlax" ID:[NSNumber numberWithInt:143] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"143"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Articuno" ID:[NSNumber numberWithInt:144] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"144"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Zapdos" ID:[NSNumber numberWithInt:145] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"145"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Moltres" ID:[NSNumber numberWithInt:146] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"146"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Dratini" ID:[NSNumber numberWithInt:147] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"147"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Dragonair" ID:[NSNumber numberWithInt:148] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"148"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Dragonite" ID:[NSNumber numberWithInt:149] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"149"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Mewtwo" ID:[NSNumber numberWithInt:150] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"150"];
    [pokeDictionary setObject:[[PokemonBase alloc] initWithPokemonName:@"Mew" ID:[NSNumber numberWithInt:151] andIsVisible:[NSNumber numberWithBool:YES]] forKey:@"151"];
    
    return pokeDictionary;
}

@end
